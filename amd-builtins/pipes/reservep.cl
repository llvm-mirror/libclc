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

#pragma OPENCL EXTENSION cl_khr_subgroups : enable
#include "pipes.h"
#include "../workgroup/wg.h"

#define __RESERVE_READ_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) size_t \
__reserve_read_pipe_internal_##SIZE(__global struct pipeimp *p, uint num_packets) \
{ \
    size_t wi = atomic_load_explicit(&p->write_idx, memory_order_relaxed, memory_scope_device); \
    size_t rid = reserve(&p->read_idx, wi, num_packets); \
 \
    if (rid + num_packets == wi) { \
        atomic_store_explicit(&p->write_idx, 0, memory_order_release, memory_scope_device); \
        atomic_store_explicit(&p->read_idx, 0, memory_order_relaxed, memory_scope_device); \
    } \
 \
    return rid; \
}

DO_PIPE_INTERNAL_SIZE(__RESERVE_READ_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) size_t
__reserve_read_pipe_internal_user(__global struct pipeimp *p, uint num_packets, size_t size)
{
    size_t wi = atomic_load_explicit(&p->write_idx, memory_order_relaxed, memory_scope_device);
    size_t rid = reserve(&p->read_idx, wi, num_packets);

    if (rid + num_packets == wi) {
        atomic_store_explicit(&p->write_idx, 0, memory_order_release, memory_scope_device);
        atomic_store_explicit(&p->read_idx, 0, memory_order_relaxed, memory_scope_device);
    }

    return rid;
}

#define __RESERVE_WRITE_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) size_t \
__reserve_write_pipe_internal_##SIZE(__global struct pipeimp *p, uint num_packets) \
{ \
    size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device); \
    size_t ei = p->end_idx; \
    return reserve(&p->write_idx, ri + ei, num_packets); \
}

DO_PIPE_INTERNAL_SIZE(__RESERVE_WRITE_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) size_t
__reserve_write_pipe_internal_user(__global struct pipeimp *p, uint num_packets, size_t size)
{
    size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device);
    size_t ei = p->end_idx;
    return reserve(&p->write_idx, ri + ei, num_packets);
}

// Work group functions

#define __WORK_GROUP_RESERVE_READ_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) size_t \
__work_group_reserve_read_pipe_internal_##SIZE(__global struct pipeimp *p, uint num_packets) \
{ \
    __local size_t *t = (__local size_t *)__wg_scratch; \
 \
    if ((int)get_local_linear_id() == 0) { \
        size_t wi = atomic_load_explicit(&p->write_idx, memory_order_relaxed, memory_scope_device); \
        size_t rid = reserve(&p->read_idx, wi, num_packets); \
 \
        if (rid + num_packets == wi) { \
            atomic_store_explicit(&p->write_idx, 0, memory_order_release, memory_scope_device); \
            atomic_store_explicit(&p->read_idx, 0, memory_order_relaxed, memory_scope_device); \
        } \
 \
        *t = rid; \
    } \
 \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
 \
    return *t; \
}

DO_PIPE_INTERNAL_SIZE(__WORK_GROUP_RESERVE_READ_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) size_t
__work_group_reserve_read_pipe_internal_user(__global struct pipeimp *p, uint num_packets, size_t size)
{
    __local size_t *t = (__local size_t *)__wg_scratch;

    if ((int)get_local_linear_id() == 0) {
        size_t wi = atomic_load_explicit(&p->write_idx, memory_order_relaxed, memory_scope_device);
        size_t rid = reserve(&p->read_idx, wi, num_packets);

        if (rid + num_packets == wi) {
            atomic_store_explicit(&p->write_idx, 0, memory_order_release, memory_scope_device);
            atomic_store_explicit(&p->read_idx, 0, memory_order_relaxed, memory_scope_device);
        }

        *t = rid;
    }

    work_group_barrier(CLK_LOCAL_MEM_FENCE);

    return *t;
}

#define __WORK_GROUP_RESERVE_WRITE_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) size_t \
__work_group_reserve_write_pipe_internal_##SIZE(__global struct pipeimp *p, uint num_packets) \
{ \
    __local size_t *t = (__local size_t *)__wg_scratch; \
 \
    if ((int)get_local_linear_id() == 0) { \
        size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device); \
        size_t ei = p->end_idx; \
        *t = reserve(&p->write_idx, ri + ei, num_packets); \
    } \
 \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
 \
    return *t; \
}

DO_PIPE_INTERNAL_SIZE(__WORK_GROUP_RESERVE_WRITE_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) size_t
__work_group_reserve_write_pipe_internal_user(__global struct pipeimp *p, uint num_packets, size_t size)
{
    __local size_t *t = (__local size_t *)__wg_scratch;

    if ((int)get_local_linear_id() == 0) {
        size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device);
        size_t ei = p->end_idx;
        *t = reserve(&p->write_idx, ri + ei, num_packets);
    }

    work_group_barrier(CLK_LOCAL_MEM_FENCE);

    return *t;
}

// sub group functions

#define __SUB_GROUP_RESERVE_READ_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) size_t \
__sub_group_reserve_read_pipe_internal_##SIZE(__global struct pipeimp *p, uint num_packets) \
{ \
    size_t rid = ~(size_t)0; \
 \
    if (get_sub_group_local_id() == 0) { \
        size_t wi = atomic_load_explicit(&p->write_idx, memory_order_relaxed, memory_scope_device); \
        rid = reserve(&p->read_idx, wi, num_packets); \
 \
        if (rid + num_packets == wi) { \
            atomic_store_explicit(&p->write_idx, 0, memory_order_release, memory_scope_device); \
            atomic_store_explicit(&p->read_idx, 0, memory_order_relaxed, memory_scope_device); \
        } \
    } \
 \
    return sub_group_broadcast(rid, 0); \
}

DO_PIPE_INTERNAL_SIZE(__SUB_GROUP_RESERVE_READ_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) size_t
__sub_group_reserve_read_pipe_internal_user(__global struct pipeimp *p, uint num_packets, size_t size)
{
    size_t rid = ~(size_t)0;

    if (get_sub_group_local_id() == 0) {
        size_t wi = atomic_load_explicit(&p->write_idx, memory_order_relaxed, memory_scope_device);
        rid = reserve(&p->read_idx, wi, num_packets);

        if (rid + num_packets == wi) {
            atomic_store_explicit(&p->write_idx, 0, memory_order_release, memory_scope_device);
            atomic_store_explicit(&p->read_idx, 0, memory_order_relaxed, memory_scope_device);
        }
    }

    return sub_group_broadcast(rid, 0);
}

#define __SUB_GROUP_RESERVE_WRITE_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) size_t \
__sub_group_reserve_write_pipe_internal_##SIZE(__global struct pipeimp *p, uint num_packets) \
{ \
    size_t rid = ~(size_t)0; \
 \
    if (get_sub_group_local_id() == 0) { \
        size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device); \
        size_t ei = p->end_idx; \
        rid = reserve(&p->write_idx, ri + ei, num_packets); \
    } \
 \
    return sub_group_broadcast(rid, 0); \
}

DO_PIPE_INTERNAL_SIZE(__SUB_GROUP_RESERVE_WRITE_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) size_t
__sub_group_reserve_write_pipe_internal_user(__global struct pipeimp *p, uint num_packets, size_t size)
{
     size_t rid = ~(size_t)0;

    if (get_sub_group_local_id() == 0) {
        size_t ri = atomic_load_explicit(&p->read_idx, memory_order_relaxed, memory_scope_device);
        size_t ei = p->end_idx;
        rid = reserve(&p->write_idx, ri + ei, num_packets);
    }

    return sub_group_broadcast(rid, 0);
}

