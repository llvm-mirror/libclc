/*
 * Copyright (c) 2014 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#if __OPENCL_C_VERSION__ >= 200

#include "devenq.h"

static inline void
copy_waitlist(__global AmdEvent **dst, __global AmdEvent **src, uint n)
{
    uint i;
    for (i=0; i<n; ++i)
        dst[i] = src[i];
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) queue_t
get_default_queue(void)
{
    return (queue_t)get_vqueue();
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) int
enqueue_marker(queue_t q, uint nwl, const clk_event_t *wl, clk_event_t *re)
{
    __global AmdVQueueHeader *vq = (__global AmdVQueueHeader *)q;
    if (nwl > vq->wait_size)
        return CLK_ENQUEUE_FAILURE;

    // Get a wrap slot
    __global uint *amask = (__global uint *)vq->aql_slot_mask;
    int ai = reserve_slot(amask, vq->aql_slot_num);
    if (ai < 0)
        return CLK_ENQUEUE_FAILURE;

    // Get a return event slot
    __global uint *emask = (__global uint *)vq->event_slot_mask;
    int ei = reserve_slot(emask, vq->event_slot_num);
    if (ei < 0) {
	release_slot(amask, ai);
        return CLK_ENQUEUE_FAILURE;
    }

    // Initialize return event
    __global AmdEvent *ev = (__global AmdEvent *)vq->event_slots + ei;
    ev->state = CL_SUBMITTED;
    ev->counter = 1;
    ev->timer[0] = 0;
    ev->timer[1] = 0;
    ev->timer[2] = 0;

    // Initialize wrap
    __global AmdAqlWrap *me = get_aql_wrap();
    __global AmdAqlWrap *aw = (__global AmdAqlWrap *)(vq + 1) + ai;

    aw->enqueue_flags = CLK_ENQUEUE_FLAGS_NO_WAIT;
    aw->command_id = atomic_fetch_add_explicit((__global atomic_uint *)&vq->command_counter, (uint)1, memory_order_acq_rel, memory_scope_device);
    aw->child_counter = 0;
    aw->completion = (ulong)ev;
    aw->parent_wrap = (ulong)me;

    if (nwl > 0)
        copy_waitlist((__global AmdEvent **)aw->wait_list, (__global AmdEvent **)wl, nwl);

    aw->wait_num = nwl;

    // A marker is never enqueued so ignore displatch packet

    // Tell the scheduler
    atomic_fetch_add_explicit((__global atomic_uint *)&me->child_counter, (uint)1, memory_order_acq_rel, memory_scope_device);
    atomic_store_explicit((__global atomic_uint *)&aw->state, AQL_WRAP_MARKER, memory_order_release, memory_scope_device);

    *re = (clk_event_t)ev;
    return 0;
}

// int
// __enqueue_internal_{0,1,.,10}[_events] (
//   queue_t q,
//   int flags,
//   int dims, size_t goff[3], size_t gsize[3], size_t lsize[3],
//   __global void * something_like_function_pointer,
//   __global void * wrap_ptr_from_prep
//   [, uint size0, uint align0
//    [, uint size1, uint align1
//     [, uint size2, uint align2
//      [, uint size3, uint align3
//       ...]]]]]] );

// Help with size and alignment handling
#define _SA_ARGS10 _SA_ARGS9, uint sz9, uint al9
#define _SA_ARGS9  _SA_ARGS8, uint sz8, uint al8
#define _SA_ARGS8  _SA_ARGS7, uint sz7, uint al7
#define _SA_ARGS7  _SA_ARGS6, uint sz6, uint al6
#define _SA_ARGS6  _SA_ARGS5, uint sz5, uint al5
#define _SA_ARGS5  _SA_ARGS4, uint sz4, uint al4
#define _SA_ARGS4  _SA_ARGS3, uint sz3, uint al3
#define _SA_ARGS3  _SA_ARGS2, uint sz2, uint al2
#define _SA_ARGS2  _SA_ARGS1, uint sz1, uint al1
#define _SA_ARGS1  _SA_ARGS0, uint sz0, uint al0
#define _SA_ARGS0

#define SA_ARGS(N) _SA_ARGS##N

#define _SET_KARG10 _SET_KARG9; lo = align_up(lo, al9); args[6+9] = lo; lo += sz9
#define _SET_KARG9  _SET_KARG8; lo = align_up(lo, al8); args[6+8] = lo; lo += sz8
#define _SET_KARG8  _SET_KARG7; lo = align_up(lo, al7); args[6+7] = lo; lo += sz7
#define _SET_KARG7  _SET_KARG6; lo = align_up(lo, al6); args[6+6] = lo; lo += sz6
#define _SET_KARG6  _SET_KARG5; lo = align_up(lo, al5); args[6+5] = lo; lo += sz5
#define _SET_KARG5  _SET_KARG4; lo = align_up(lo, al4); args[6+4] = lo; lo += sz4
#define _SET_KARG4  _SET_KARG3; lo = align_up(lo, al3); args[6+3] = lo; lo += sz3
#define _SET_KARG3  _SET_KARG2; lo = align_up(lo, al2); args[6+2] = lo; lo += sz2
#define _SET_KARG2  _SET_KARG1; lo = align_up(lo, al1); args[6+1] = lo; lo += sz1
#define _SET_KARG1              lo = align_up(lo, al0); args[6+0] = lo; lo += sz0
#define _SET_KARG0

#define SET_KARG(N) _SET_KARG##N

#define GEN(N) \
__attribute__((always_inline)) \
int \
__enqueue_internal_##N(queue_t q, int flags, ndrange_t ndr_type, \
	               __global void *fp, __global void *aqlWrap SA_ARGS(N)) \
{ \
    __global AmdVQueueHeader *vq = (__global AmdVQueueHeader *)q; \
    __global AmdAqlWrap *me = get_aql_wrap(); \
    __global uint *amask = (__global uint *)vq->aql_slot_mask; \
    __global AmdAqlWrap *aw = (__global AmdAqlWrap *) aqlWrap; \
    int ai = aw - (__global AmdAqlWrap *)(vq + 1); \
    __private NdRange *ndr = (__private NdRange *) &ndr_type; \
 \
    /* Skip check of dim for now */ \
    if (mul24(mul24((uint)ndr->lws[0], (uint)ndr->lws[1]), (uint)ndr->lws[2]) > \
	CL_DEVICE_MAX_WORK_GROUP_SIZE) { \
	release_slot(amask, ai); \
	return CLK_ENQUEUE_FAILURE; \
    } \
 \
    /* This is the current index-based approach, not the ldk based approach */ \
    __global AmdKernelCode **kt = (__global AmdKernelCode **)vq->kernel_table; \
    uint ki = (uint)fp; \
    __global AmdKernelCode *kc = kt[ki]; \
 \
    aw->enqueue_flags = flags; \
 \
    aw->command_id = atomic_fetch_add_explicit((__global atomic_uint *)&vq->command_counter, (uint)1, memory_order_acq_rel, memory_scope_device); \
    aw->child_counter = 0; \
    aw->completion = 0; \
    aw->parent_wrap = (ulong)me; \
    aw->wait_num = 0; \
 \
    aw->aql.mix = ((uint)ndr->dim << 16) | (0x1 << 11) | (0x1 << 9) |(0x0 << 8) | (0x2 << 0); \
    aw->aql.workgroup_size[0] = (ushort)ndr->lws[0]; \
    aw->aql.workgroup_size[1] = (ushort)ndr->lws[1]; \
    aw->aql.workgroup_size[2] = (ushort)ndr->lws[2]; \
    aw->aql.grid_size[0] = (uint)ndr->gws[0]; \
    aw->aql.grid_size[1] = (uint)ndr->gws[1]; \
    aw->aql.grid_size[2] = (uint)ndr->gws[2]; \
    aw->aql.private_segment_size_bytes = kc->workitem_private_segment_byte_size; \
    aw->aql.group_segment_size_bytes = 0; \
    aw->aql.kernel_object_address = (ulong)kc; \
    aw->aql.completion_signal = 0; \
 \
    /* Set non-capture arguments */ \
    __global size_t *args = (__global size_t *)aw->aql.kernel_arg_address; \
    args[0] = ndr->goff[0]; \
    args[1] = ndr->goff[1]; \
    args[2] = ndr->goff[2]; \
    args[3] = (size_t)get_printf_ptr(); \
    args[4] = (size_t)vq; \
    args[5] = (size_t)aw; \
 \
    uint lo0 = kc->workgroup_group_segment_byte_size; \
    uint lo = lo0; \
    SET_KARG(N); \
    aw->aql.group_segment_size_bytes = lo - lo0; \
 \
    /* Tell the scheduler */ \
    atomic_fetch_add_explicit((__global atomic_uint *)&me->child_counter, (uint)1, memory_order_acq_rel, memory_scope_device); \
    atomic_store_explicit((__global atomic_uint *)&aw->state, AQL_WRAP_READY, memory_order_release, memory_scope_device); \
    return 0; \
}

GEN(0)
GEN(1)
GEN(2)
GEN(3)
GEN(4)
GEN(5)
GEN(6)
GEN(7)
GEN(8)
GEN(9)
GEN(10)

// Now the versions with events

#define EGEN(N) \
__attribute__((always_inline)) \
int \
__enqueue_internal_##N##_events(queue_t q, int flags, ndrange_t ndr_type, \
	                        uint nwl, clk_event_t *wl, clk_event_t *re, \
	                        __global void *fp, __global void *aqlWrap SA_ARGS(N)) \
{ \
    __global AmdVQueueHeader *vq = (__global AmdVQueueHeader *)q; \
    __global uint *amask = (__global uint *)vq->aql_slot_mask; \
    __global AmdAqlWrap *aw = (__global AmdAqlWrap *) aqlWrap; \
    int ai = aw - (__global AmdAqlWrap *)(vq + 1); \
     __private NdRange *ndr = (__private NdRange *) &ndr_type; \
 \
    /* Skip check of dim for now */ \
    if (mul24(mul24((uint)ndr->lws[0], (uint)ndr->lws[1]), (uint)ndr->lws[2]) > \
	CL_DEVICE_MAX_WORK_GROUP_SIZE | nwl > vq->wait_size) { \
        release_slot(amask, ai); \
        return CLK_ENQUEUE_FAILURE; \
    } \
 \
    __global AmdAqlWrap *me = get_aql_wrap(); \
    __global AmdEvent *ev = NULL; \
 \
    if (re != NULL) { \
        /* Get a return event slot */ \
        __global uint *emask = (__global uint *)vq->event_slot_mask; \
        int ei = reserve_slot(emask, vq->event_slot_num); \
        if (ei < 0) { \
            release_slot(amask, ai); \
            return CLK_ENQUEUE_FAILURE; \
	} \
 \
        /* Initialize return event */ \
        ev = (__global AmdEvent *)vq->event_slots + ei; \
        ev->state = CL_SUBMITTED; \
        ev->counter = 1; \
        ev->timer[0] = 0; \
        ev->timer[1] = 0; \
        ev->timer[2] = 0; \
    } \
 \
    /* This is the current index-based approach, not the ldk based approach */ \
    __global AmdKernelCode **kt = (__global AmdKernelCode **)vq->kernel_table; \
    uint ki = (uint)fp; \
    __global AmdKernelCode *kc = kt[ki]; \
 \
    aw->enqueue_flags = flags; \
 \
    aw->command_id = atomic_fetch_add_explicit((__global atomic_uint *)&vq->command_counter, (uint)1, memory_order_acq_rel, memory_scope_device); \
    aw->child_counter = 0; \
    aw->completion = 0; \
    aw->parent_wrap = (ulong)me; \
 \
    aw->aql.mix = ((uint)ndr->dim << 16) | (0x1 << 11) | (0x1 << 9) |(0x0 << 8) | (0x2 << 0); \
    aw->aql.workgroup_size[0] = (ushort)ndr->lws[0]; \
    aw->aql.workgroup_size[1] = (ushort)ndr->lws[1]; \
    aw->aql.workgroup_size[2] = (ushort)ndr->lws[2]; \
    aw->aql.grid_size[0] = (uint)ndr->gws[0]; \
    aw->aql.grid_size[1] = (uint)ndr->gws[1]; \
    aw->aql.grid_size[2] = (uint)ndr->gws[2]; \
    aw->aql.private_segment_size_bytes = kc->workitem_private_segment_byte_size; \
    aw->aql.group_segment_size_bytes = 0; \
    aw->aql.kernel_object_address = (ulong)kc; \
    aw->aql.completion_signal = 0; \
 \
    /* Set non-capture arguments */ \
    __global size_t *args = (__global size_t *)aw->aql.kernel_arg_address; \
    args[0] = ndr->goff[0]; \
    args[1] = ndr->goff[1]; \
    args[2] = ndr->goff[2]; \
    args[3] = (size_t)get_printf_ptr(); \
    args[4] = (size_t)vq; \
    args[5] = (size_t)aw; \
 \
    uint lo0 = kc->workgroup_group_segment_byte_size; \
    uint lo = lo0; \
    SET_KARG(N); \
    aw->aql.group_segment_size_bytes = lo - lo0; \
 \
    /* Copy wait list */ \
    if (nwl > 0) \
        copy_waitlist((__global AmdEvent **)aw->wait_list, (__global AmdEvent **)wl, nwl); \
 \
    aw->wait_num = nwl; \
 \
    /* Tell the scheduler */ \
    atomic_fetch_add_explicit((__global atomic_uint *)&me->child_counter, (uint)1, memory_order_acq_rel, memory_scope_device); \
    atomic_store_explicit((__global atomic_uint *)&aw->state, AQL_WRAP_MARKER, memory_order_release, memory_scope_device); \
 \
    if (re != NULL) \
        *re = (clk_event_t)ev; \
 \
    return 0; \
}

EGEN(0)
EGEN(1)
EGEN(2)
EGEN(3)
EGEN(4)
EGEN(5)
EGEN(6)
EGEN(7)
EGEN(8)
EGEN(9)
EGEN(10)

#endif

