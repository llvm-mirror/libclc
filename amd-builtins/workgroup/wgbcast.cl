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

#include "wg.h"

#define GEN_BROADCAST(TYPE) \
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_broadcast(TYPE a, size_t local_id_x) \
{ \
    if (get_num_sub_groups() == 1) \
        return sub_group_broadcast(a, local_id_x); \
 \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    if (get_local_id(0) == local_id_x) \
        *p = a; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    a = *p; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return a; \
} \
\
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_broadcast(TYPE a, size_t local_id_x, size_t local_id_y) \
{ \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    if (get_local_id(0) == local_id_x && get_local_id(1) == local_id_y) \
        *p = a; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    a = *p; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return a; \
} \
\
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_broadcast(TYPE a, size_t local_id_x, size_t local_id_y, size_t local_id_z) \
{ \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    if (get_local_id(0) == local_id_x && get_local_id(1) == local_id_y && get_local_id(2) == local_id_z) \
        *p = a; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    a = *p; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return a; \
}

GEN_BROADCAST(uint)
GEN_BROADCAST(int)
GEN_BROADCAST(ulong)
GEN_BROADCAST(long)
GEN_BROADCAST(float)
GEN_BROADCAST(double)

#endif

