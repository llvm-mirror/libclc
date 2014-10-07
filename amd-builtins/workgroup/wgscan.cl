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

#include "wg.h"

#if __OPENCL_C_VERSION__ >= 200

#define GENIA(TYPE) \
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_scan_inclusive_add(TYPE a) \
{ \
    uint n = get_num_sub_groups(); \
    a = sub_group_scan_inclusive_add(a); \
    if (n == 1) \
        return a; \
 \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    uint l = get_sub_group_local_id(); \
    uint i = get_sub_group_id(); \
 \
    if (l == get_sub_group_size() - 1U) \
	p[i] = a; \
 \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    if (i == 0) { \
	TYPE t = l < n ? p[l] : (TYPE)0; \
	t = sub_group_scan_inclusive_add(t); \
	if (l < n) \
	    p[l] = t; \
    } \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    TYPE ret = i == 0 ? a : a + p[i-1]; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return ret; \
}

#define GENIO(TYPE,SUF,ID) \
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_scan_inclusive_##SUF(TYPE a) \
{ \
    uint n = get_num_sub_groups(); \
    a = sub_group_scan_inclusive_##SUF(a); \
    if (n == 1) \
        return a; \
 \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    uint l = get_sub_group_local_id(); \
    uint i = get_sub_group_id(); \
 \
    if (l == get_sub_group_size() - 1U) \
	p[i] = a; \
 \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    if (i == 0) { \
	TYPE t = l < n ? p[l] : ID; \
	t = sub_group_scan_inclusive_##SUF(t); \
	if (l < n) \
	    p[l] = t; \
    } \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    TYPE ret = i == 0 ? a : SUF(a, p[i-1]); \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return ret; \
}

GENIA(int)
GENIA(uint)
GENIA(long)
GENIA(ulong)
GENIA(float)
GENIA(double)

GENIO(int,max,INT_MIN)
GENIO(uint,max,0U)
GENIO(long,max,LONG_MIN)
GENIO(ulong,max,0UL)
GENIO(float,max,-INFINITY)
GENIO(double,max,-(double)INFINITY)

GENIO(int,min,INT_MAX)
GENIO(uint,min,UINT_MAX)
GENIO(long,min,LONG_MAX)
GENIO(ulong,min,ULONG_MAX)
GENIO(float,min,INFINITY)
GENIO(double,min,(double)INFINITY)

#define GENEA(TYPE) \
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_scan_exclusive_add(TYPE a) \
{ \
    uint n = get_num_sub_groups(); \
    TYPE t = sub_group_scan_exclusive_add(a); \
    if (n == 1) \
        return t; \
 \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    uint l = get_sub_group_local_id(); \
    uint i = get_sub_group_id(); \
 \
    if (l == get_sub_group_size() - 1U) \
	p[i] = a + t; \
 \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    if (i == 0) { \
	TYPE s = l < n ? p[l] : (TYPE)0; \
	s = sub_group_scan_inclusive_add(s); \
	if (l < n) \
	    p[l] = s; \
    } \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    TYPE ret = i == 0 ? t : t + p[i-1]; \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return ret; \
}

#define GENEO(TYPE,SUF,ID) \
__attribute__((overloadable,weak,always_inline)) TYPE \
work_group_scan_exclusive_##SUF(TYPE a) \
{ \
    uint n = get_num_sub_groups(); \
    TYPE t = sub_group_scan_exclusive_##SUF(a); \
    if (n == 1) \
        return t; \
 \
    __local TYPE *p = (__local TYPE *)__wg_scratch; \
    uint l = get_sub_group_local_id(); \
    uint i = get_sub_group_id(); \
 \
    if (l == get_sub_group_size() - 1U) \
	p[i] = SUF(a, t); \
 \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    if (i == 0) { \
	TYPE s = l < n ? p[l] : ID; \
	s = sub_group_scan_inclusive_##SUF(s); \
	if (l < n) \
	    p[l] = s; \
    } \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    TYPE ret = i == 0 ? t : SUF(t, p[i-1]); \
    work_group_barrier(CLK_LOCAL_MEM_FENCE); \
    return ret; \
}

GENEA(int)
GENEA(uint)
GENEA(long)
GENEA(ulong)
GENEA(float)
GENEA(double)

GENEO(int,max,INT_MIN)
GENEO(uint,max,0U)
GENEO(long,max,LONG_MIN)
GENEO(ulong,max,0UL)
GENEO(float,max,-INFINITY)
GENEO(double,max,-(double)INFINITY)

GENEO(int,min,INT_MAX)
GENEO(uint,min,UINT_MAX)
GENEO(long,min,LONG_MAX)
GENEO(ulong,min,ULONG_MAX)
GENEO(float,min,INFINITY)
GENEO(double,min,(double)INFINITY)

#endif

