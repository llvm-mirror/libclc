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

#define GENA(TYPE) \
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_reduce_add(TYPE a) \
{ \
    uint n = get_num_sub_groups(); \
    a = sub_group_reduce_add(a); \
    if (n == 1) \
        return a; \
 \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    uint l = get_sub_group_local_id(); \
    uint i = get_sub_group_id(); \
 \
    if (l == 0) \
        p[i] = a; \
 \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    if (i == 0) { \
	a = l < n ? p[l] : (TYPE)0; \
	a = sub_group_reduce_add(a); \
	if (l == 0) \
	    p[0] = a; \
    } \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    a = p[0]; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return a; \
}

#define GENO(TYPE,SUF,ID) \
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_reduce_##SUF(TYPE a) \
{ \
    uint n = get_num_sub_groups(); \
    a = sub_group_reduce_##SUF(a); \
    if (n == 1) \
        return a; \
 \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    uint l = get_sub_group_local_id(); \
    uint i = get_sub_group_id(); \
 \
    if (l == 0) \
        p[i] = a; \
 \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    if (i == 0) { \
	a = l < n ? p[l] : ID; \
	a = sub_group_reduce_##SUF(a); \
	if (l == 0) \
	    p[0] = a; \
    } \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    a = p[0]; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return a; \
}

GENA(int)
GENA(uint)
GENA(long)
GENA(ulong)
GENA(float)
GENA(double)

GENO(int,max,INT_MIN)
GENO(uint,max,0U)
GENO(long,max,LONG_MIN)
GENO(ulong,max,0UL)
GENO(float,max,-INFINITY)
GENO(double,max,-(double)INFINITY)

GENO(int,min,INT_MAX)
GENO(uint,min,UINT_MAX)
GENO(long,min,LONG_MAX)
GENO(ulong,min,ULONG_MAX)
GENO(float,min,INFINITY)
GENO(double,min,(double)INFINITY)

#endif

