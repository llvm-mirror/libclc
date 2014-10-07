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

#include "pipes.h"

#define __WRITE_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) int \
__write_pipe_internal_##SIZE(__global struct pipeimp* p, const STYPE* ptr) \
{ \
    size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device); \
    size_t ei = p->end_idx; \
    size_t wi = reserve(&p->write_idx, ri+ei, 1); \
    if (wi == ~(size_t)0) \
        return -1; \
 \
    ((__global STYPE *)p->packets)[wi % ei] = *ptr; \
    return 0; \
}

DO_PIPE_INTERNAL_SIZE(__WRITE_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) int
__write_pipe_internal_user(__global struct pipeimp* p, const void* ptr, size_t size, size_t align)
{
    size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device);
    size_t ei = p->end_idx;
    size_t wi = reserve(&p->write_idx, ri+ei, 1);
    if (wi == ~(size_t)0)
        return -1;

    __memcpy_internal_aligned(p->packets + (wi % ei)*size, ptr, size, align);

    return 0;
}

#define __WRITE_PIPE_INDEXED_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) int \
__write_pipe_reserved_internal_##SIZE(__global struct pipeimp* p, size_t rid, uint i, const STYPE* ptr)  \
{ \
    rid += i; \
    ((__global STYPE *)p->packets)[rid % p->end_idx] = *ptr; \
    return 0; \
}

DO_PIPE_INTERNAL_SIZE(__WRITE_PIPE_INDEXED_INTERNAL_SIZE)

__attribute__((weak, always_inline)) int
__write_pipe_reserved_internal_user(__global struct pipeimp* p, size_t rid, uint i, const void *ptr, size_t size, size_t align)
{
    rid += i;

    __memcpy_internal_aligned(p->packets + (rid % p->end_idx)*size, ptr, size, align);

    return 0;
}

