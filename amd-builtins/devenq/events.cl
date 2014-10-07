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

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) void
retain_event(clk_event_t e)
{
    __global AmdEvent *ev = (__global AmdEvent *)e;
    atomic_fetch_add_explicit((__global atomic_uint *)&ev->counter, 1U, memory_order_acq_rel, memory_scope_device);
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) void
release_event(clk_event_t e)
{
    __global AmdEvent *ev = (__global AmdEvent *)e;
    uint c = atomic_fetch_sub_explicit((__global atomic_uint *)&ev->counter, 1U, memory_order_acq_rel, memory_scope_device);
    if (c == 1U) {
        __global AmdVQueueHeader *vq = get_vqueue();
        __global uint *emask = (__global uint *)vq->event_slot_mask;
        __global AmdEvent *eb = (__global AmdEvent *)vq->event_slots;
        uint i = ev - eb;
        release_slot(emask, i);
    }
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) clk_event_t
create_user_event(void)
{
    __global AmdVQueueHeader *vq = get_vqueue();
    __global uint *emask = (__global uint *)vq->event_slot_mask;
    int i = reserve_slot(emask, vq->event_slot_num);

    if (i >= 0) {
        __global AmdEvent *ev = (__global AmdEvent *)vq->event_slots + i;
        ev->state = CL_SUBMITTED;
        ev->counter = 1;
        ev->timer[0] = 0;
        ev->timer[1] = 0;
        ev->timer[2] = 0;
        return (clk_event_t)ev;
    } else
        return (clk_event_t)(__global void *)NULL;
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) bool
is_valid_event(clk_event_t e)
{
    return !((__global AmdEvent *)e == NULL);
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) void
set_user_event_status(clk_event_t e, int s)
{
    __global AmdEvent *ev = (__global AmdEvent *)e;
    atomic_store_explicit((__global atomic_uint *)&ev->state, (uint)s, memory_order_release, memory_scope_device);
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) void
capture_event_profiling_info(clk_event_t e, clk_profiling_info n, __global void *p)
{
    // Currently the second argument must be CLK_PROFILING_COMMAND_EXEC_TIME
    __global AmdEvent *ev = (__global AmdEvent *)e;
    __global ulong *t = (__global ulong *)ev->timer;
    
    ((__global ulong *)p)[0] = t[PROFILING_COMMAND_END] - t[PROFILING_COMMAND_START];
    ((__global ulong *)p)[1] = t[PROFILING_COMMAND_COMPLETE] - t[PROFILING_COMMAND_START];
}

#endif

