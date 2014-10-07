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
//
// Copyright (c) 2014 Advanced Micro Devices, Inc. All rights reserved.
//

#ifndef _PIPES_H
#define _PIPES_H 1

#pragma OPENCL EXTENSION cl_khr_int64_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_int64_extended_atomics : enable
 
#define DO_PIPE_INTERNAL_SIZE(F) \
F(1,uchar) \
F(2,ushort) \
F(4,uint) \
F(8,ulong) \
F(16,ulong2) \
F(32,ulong4) \
F(64,ulong8) \
F(128,ulong16)

struct pipeimp {
    atomic_size_t read_idx;
    atomic_size_t write_idx;
    size_t end_idx;
    uchar pad[128 - 3*sizeof(size_t)];
    uchar packets[1];
};

extern void __memcpy_internal_aligned(void *, const void *, size_t, size_t);

static inline size_t
reserve(volatile __global atomic_size_t *pidx, size_t lim, size_t n)
{
    size_t idx = atomic_load_explicit(pidx, memory_order_acquire, memory_scope_device);

    for (;;) {
	if (idx + n > lim)
	    return ~(size_t)0;

	if (atomic_compare_exchange_strong_explicit(pidx, &idx, idx + n, memory_order_acq_rel, memory_order_acquire, memory_scope_device))
	    break;
    }

    return idx;
}

#endif // _PIPES_H

