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
copy_captured_context(__global void *d, __private void *s, uint size, uint align)
{
    if (align == 2) {
	__global short *d2 = (__global short *)d;
	__private short *s2 = (__private short *)s;
        uint i;
        uint n = size / align;

	for (i=0; i<n; ++i)
	    d2[i] = s2[i];
    } else if (align == 4) {
	__global int *d4 = (__global int *)d;
	__private int *s4 = (__private int *)s;
        uint i;
        uint n = size / align;

	for (i=0; i<n; ++i)
	    d4[i] = s4[i];
    } else if (align == 8) {
	__global long *d8 = (__global long *)d;
	__private long *s8 = (__private long *)s;
        uint i;
        uint n = size / align;

	for (i=0; i<n; ++i)
	    d8[i] = s8[i];
    } else if (align == 16) {
	__global long2 *d16 = (__global long2 *)d;
	__private long2 *s16 = (__private long2 *)s;
        uint i;
        uint n = size / align;

	for (i=0; i<n; ++i)
	    d16[i] = s16[i];
    } else if (align == 32 || align == 64 || align == 128) {
	__global long4 *d32 = (__global long4 *)d;
	__private long4 *s32 = (__private long4 *)s;
        uint i;
        uint n = size / 32U;

	for (i=0; i<n; ++i)
	    d32[i] = s32[i];
    } else {
	__global char *d1 = (__global char *)d;
	__private char *s1 = (__private char *)s;
	uint i;
	uint n = size;

	for (i=0; i<n; ++i)
	    d1[i] = s1[i];
    }
}

// enqueue_prep attempts to allocate an AqlWrap and copy the
// context into the kernarg area
// returns:
//   1: a int indicating the allocation is successful
//   2: a pointer to the wrap itself to be passed to the actual enqueue
//      call
static int
eprep(queue_t q, uint lsize, uint csize, uint calign, __private void *cptr, __global void* private* private wretp)
{
    __global AmdVQueueHeader *vq = (__global AmdVQueueHeader *)q;

    lsize = align_up(lsize, calign);
    if (lsize + csize > vq->arg_size)
	return CLK_ENQUEUE_FAILURE;

    int s = reserve_slot((__global uint *)vq->aql_slot_mask, vq->aql_slot_num);
    if (s < 0)
	return CLK_ENQUEUE_FAILURE;

    __global AmdAqlWrap *a = (__global AmdAqlWrap *)(vq + 1);
    __global void *kptr = (__global void *)((size_t)a[s].aql.kernel_arg_address + NUM_SPECIAL_ARGS*sizeof(size_t));
    copy_captured_context(kptr, cptr, csize, calign);

    *wretp = (__global void *)(a + s);
    return CLK_SUCCESS;
}

#define GEN(N) \
__attribute__((always_inline)) int \
__enqueue_prep_##N(queue_t q, size_t csize, uint calign, __private void *cptr, __global void* private* private wretp) \
{ \
    return eprep(q, (uint)((N + NUM_SPECIAL_ARGS)*sizeof(size_t)), (uint)csize, calign, cptr, wretp); \
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

#endif

