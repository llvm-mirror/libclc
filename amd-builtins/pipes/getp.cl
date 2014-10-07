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

#define __GET_PIPE_NUM_PACKETS_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) uint \
__get_pipe_num_packets_internal_##SIZE(__global struct pipeimp* p) \
{ \
    size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device); \
    size_t wi = atomic_load_explicit(&p->write_idx, memory_order_relaxed, memory_scope_device); \
    return (uint)(wi - ri); \
}

DO_PIPE_INTERNAL_SIZE(__GET_PIPE_NUM_PACKETS_INTERNAL_SIZE)

__attribute__((weak, always_inline)) uint
__get_pipe_num_packets_internal_user(__global struct pipeimp* p, size_t size)
{
    size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device);
    size_t wi = atomic_load_explicit(&p->write_idx, memory_order_relaxed, memory_scope_device);
    return (uint)(wi - ri);
}

#define __GET_PIPE_MAX_PACKETS_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) uint \
__get_pipe_max_packets_internal_##SIZE(__global struct pipeimp* p) \
{ \
    return (uint)p->end_idx; \
}

DO_PIPE_INTERNAL_SIZE(__GET_PIPE_MAX_PACKETS_INTERNAL_SIZE)

__attribute__((weak, always_inline)) uint
__get_pipe_max_packets_internal_user(__global struct pipeimp* p, size_t size)
{
    return (uint)p->end_idx;
}

