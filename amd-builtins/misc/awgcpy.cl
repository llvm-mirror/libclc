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

extern __attribute__((pure)) int __hsail_workitemid_flat(void);

__attribute__((always_inline)) static event_t
__AWGClgI1(__local uchar * dst, const __global uchar * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClgI1"))) event_t async_work_group_copy(__local uchar *, const __global uchar *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClgI1"))) event_t async_work_group_copy(__local char *, const __global char *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClgI1(__local uchar *dst, const __global uchar *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClgI1"))) event_t async_work_group_strided_copy(__local uchar *, const __global uchar *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClgI1"))) event_t async_work_group_strided_copy(__local char *, const __global char *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCglI1(__global uchar * dst, const __local uchar * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCglI1"))) event_t async_work_group_copy(__global uchar *, const __local uchar *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCglI1"))) event_t async_work_group_copy(__global char *, const __local char *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCglI1(__global uchar *dst, const __local uchar *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCglI1"))) event_t async_work_group_strided_copy(__global uchar *, const __local uchar *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCglI1"))) event_t async_work_group_strided_copy(__global char *, const __local char *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uchar *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global char *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClgI2(__local ushort * dst, const __global ushort * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClgI2"))) event_t async_work_group_copy(__local ushort *, const __global ushort *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClgI2"))) event_t async_work_group_copy(__local short *, const __global short *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClgI2(__local ushort *dst, const __global ushort *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClgI2"))) event_t async_work_group_strided_copy(__local ushort *, const __global ushort *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClgI2"))) event_t async_work_group_strided_copy(__local short *, const __global short *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCglI2(__global ushort * dst, const __local ushort * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCglI2"))) event_t async_work_group_copy(__global ushort *, const __local ushort *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCglI2"))) event_t async_work_group_copy(__global short *, const __local short *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCglI2(__global ushort *dst, const __local ushort *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCglI2"))) event_t async_work_group_strided_copy(__global ushort *, const __local ushort *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCglI2"))) event_t async_work_group_strided_copy(__global short *, const __local short *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ushort *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global short *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClgI4(__local uint * dst, const __global uint * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClgI4"))) event_t async_work_group_copy(__local uint *, const __global uint *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClgI4"))) event_t async_work_group_copy(__local int *, const __global int *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClgI4(__local uint *dst, const __global uint *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClgI4"))) event_t async_work_group_strided_copy(__local uint *, const __global uint *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClgI4"))) event_t async_work_group_strided_copy(__local int *, const __global int *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCglI4(__global uint * dst, const __local uint * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCglI4"))) event_t async_work_group_copy(__global uint *, const __local uint *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCglI4"))) event_t async_work_group_copy(__global int *, const __local int *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCglI4(__global uint *dst, const __local uint *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCglI4"))) event_t async_work_group_strided_copy(__global uint *, const __local uint *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCglI4"))) event_t async_work_group_strided_copy(__global int *, const __local int *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uint *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global int *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClgI8(__local ulong * dst, const __global ulong * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClgI8"))) event_t async_work_group_copy(__local ulong *, const __global ulong *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClgI8"))) event_t async_work_group_copy(__local long *, const __global long *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClgI8(__local ulong *dst, const __global ulong *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClgI8"))) event_t async_work_group_strided_copy(__local ulong *, const __global ulong *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClgI8"))) event_t async_work_group_strided_copy(__local long *, const __global long *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCglI8(__global ulong * dst, const __local ulong * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCglI8"))) event_t async_work_group_copy(__global ulong *, const __local ulong *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCglI8"))) event_t async_work_group_copy(__global long *, const __local long *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCglI8(__global ulong *dst, const __local ulong *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCglI8"))) event_t async_work_group_strided_copy(__global ulong *, const __local ulong *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCglI8"))) event_t async_work_group_strided_copy(__global long *, const __local long *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ulong *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global long *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local float * dst, const __global float * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local float *dst, const __global float *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global float * dst, const __local float * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global float *dst, const __local float *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global float *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local double * dst, const __global double * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local double *dst, const __global double *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global double * dst, const __local double * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global double *dst, const __local double *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global double *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg2I1(__local uchar2 * dst, const __global uchar2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg2I1"))) event_t async_work_group_copy(__local uchar2 *, const __global uchar2 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg2I1"))) event_t async_work_group_copy(__local char2 *, const __global char2 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg2I1(__local uchar2 *dst, const __global uchar2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg2I1"))) event_t async_work_group_strided_copy(__local uchar2 *, const __global uchar2 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg2I1"))) event_t async_work_group_strided_copy(__local char2 *, const __global char2 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl2I1(__global uchar2 * dst, const __local uchar2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl2I1"))) event_t async_work_group_copy(__global uchar2 *, const __local uchar2 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl2I1"))) event_t async_work_group_copy(__global char2 *, const __local char2 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl2I1(__global uchar2 *dst, const __local uchar2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl2I1"))) event_t async_work_group_strided_copy(__global uchar2 *, const __local uchar2 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl2I1"))) event_t async_work_group_strided_copy(__global char2 *, const __local char2 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uchar2 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global char2 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg2I2(__local ushort2 * dst, const __global ushort2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg2I2"))) event_t async_work_group_copy(__local ushort2 *, const __global ushort2 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg2I2"))) event_t async_work_group_copy(__local short2 *, const __global short2 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg2I2(__local ushort2 *dst, const __global ushort2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg2I2"))) event_t async_work_group_strided_copy(__local ushort2 *, const __global ushort2 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg2I2"))) event_t async_work_group_strided_copy(__local short2 *, const __global short2 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl2I2(__global ushort2 * dst, const __local ushort2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl2I2"))) event_t async_work_group_copy(__global ushort2 *, const __local ushort2 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl2I2"))) event_t async_work_group_copy(__global short2 *, const __local short2 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl2I2(__global ushort2 *dst, const __local ushort2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl2I2"))) event_t async_work_group_strided_copy(__global ushort2 *, const __local ushort2 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl2I2"))) event_t async_work_group_strided_copy(__global short2 *, const __local short2 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ushort2 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global short2 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg2I4(__local uint2 * dst, const __global uint2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg2I4"))) event_t async_work_group_copy(__local uint2 *, const __global uint2 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg2I4"))) event_t async_work_group_copy(__local int2 *, const __global int2 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg2I4(__local uint2 *dst, const __global uint2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg2I4"))) event_t async_work_group_strided_copy(__local uint2 *, const __global uint2 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg2I4"))) event_t async_work_group_strided_copy(__local int2 *, const __global int2 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl2I4(__global uint2 * dst, const __local uint2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl2I4"))) event_t async_work_group_copy(__global uint2 *, const __local uint2 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl2I4"))) event_t async_work_group_copy(__global int2 *, const __local int2 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl2I4(__global uint2 *dst, const __local uint2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl2I4"))) event_t async_work_group_strided_copy(__global uint2 *, const __local uint2 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl2I4"))) event_t async_work_group_strided_copy(__global int2 *, const __local int2 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uint2 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global int2 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg2I8(__local ulong2 * dst, const __global ulong2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg2I8"))) event_t async_work_group_copy(__local ulong2 *, const __global ulong2 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg2I8"))) event_t async_work_group_copy(__local long2 *, const __global long2 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg2I8(__local ulong2 *dst, const __global ulong2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg2I8"))) event_t async_work_group_strided_copy(__local ulong2 *, const __global ulong2 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg2I8"))) event_t async_work_group_strided_copy(__local long2 *, const __global long2 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl2I8(__global ulong2 * dst, const __local ulong2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl2I8"))) event_t async_work_group_copy(__global ulong2 *, const __local ulong2 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl2I8"))) event_t async_work_group_copy(__global long2 *, const __local long2 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl2I8(__global ulong2 *dst, const __local ulong2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl2I8"))) event_t async_work_group_strided_copy(__global ulong2 *, const __local ulong2 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl2I8"))) event_t async_work_group_strided_copy(__global long2 *, const __local long2 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ulong2 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global long2 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local float2 * dst, const __global float2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local float2 *dst, const __global float2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global float2 * dst, const __local float2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global float2 *dst, const __local float2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global float2 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local double2 * dst, const __global double2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local double2 *dst, const __global double2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global double2 * dst, const __local double2 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global double2 *dst, const __local double2 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global double2 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg3I1(__local uchar3 * dst, const __global uchar3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg3I1"))) event_t async_work_group_copy(__local uchar3 *, const __global uchar3 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg3I1"))) event_t async_work_group_copy(__local char3 *, const __global char3 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg3I1(__local uchar3 *dst, const __global uchar3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg3I1"))) event_t async_work_group_strided_copy(__local uchar3 *, const __global uchar3 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg3I1"))) event_t async_work_group_strided_copy(__local char3 *, const __global char3 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl3I1(__global uchar3 * dst, const __local uchar3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl3I1"))) event_t async_work_group_copy(__global uchar3 *, const __local uchar3 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl3I1"))) event_t async_work_group_copy(__global char3 *, const __local char3 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl3I1(__global uchar3 *dst, const __local uchar3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl3I1"))) event_t async_work_group_strided_copy(__global uchar3 *, const __local uchar3 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl3I1"))) event_t async_work_group_strided_copy(__global char3 *, const __local char3 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uchar3 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global char3 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg3I2(__local ushort3 * dst, const __global ushort3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg3I2"))) event_t async_work_group_copy(__local ushort3 *, const __global ushort3 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg3I2"))) event_t async_work_group_copy(__local short3 *, const __global short3 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg3I2(__local ushort3 *dst, const __global ushort3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg3I2"))) event_t async_work_group_strided_copy(__local ushort3 *, const __global ushort3 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg3I2"))) event_t async_work_group_strided_copy(__local short3 *, const __global short3 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl3I2(__global ushort3 * dst, const __local ushort3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl3I2"))) event_t async_work_group_copy(__global ushort3 *, const __local ushort3 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl3I2"))) event_t async_work_group_copy(__global short3 *, const __local short3 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl3I2(__global ushort3 *dst, const __local ushort3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl3I2"))) event_t async_work_group_strided_copy(__global ushort3 *, const __local ushort3 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl3I2"))) event_t async_work_group_strided_copy(__global short3 *, const __local short3 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ushort3 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global short3 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg3I4(__local uint3 * dst, const __global uint3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg3I4"))) event_t async_work_group_copy(__local uint3 *, const __global uint3 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg3I4"))) event_t async_work_group_copy(__local int3 *, const __global int3 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg3I4(__local uint3 *dst, const __global uint3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg3I4"))) event_t async_work_group_strided_copy(__local uint3 *, const __global uint3 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg3I4"))) event_t async_work_group_strided_copy(__local int3 *, const __global int3 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl3I4(__global uint3 * dst, const __local uint3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl3I4"))) event_t async_work_group_copy(__global uint3 *, const __local uint3 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl3I4"))) event_t async_work_group_copy(__global int3 *, const __local int3 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl3I4(__global uint3 *dst, const __local uint3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl3I4"))) event_t async_work_group_strided_copy(__global uint3 *, const __local uint3 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl3I4"))) event_t async_work_group_strided_copy(__global int3 *, const __local int3 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uint3 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global int3 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg3I8(__local ulong3 * dst, const __global ulong3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg3I8"))) event_t async_work_group_copy(__local ulong3 *, const __global ulong3 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg3I8"))) event_t async_work_group_copy(__local long3 *, const __global long3 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg3I8(__local ulong3 *dst, const __global ulong3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg3I8"))) event_t async_work_group_strided_copy(__local ulong3 *, const __global ulong3 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg3I8"))) event_t async_work_group_strided_copy(__local long3 *, const __global long3 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl3I8(__global ulong3 * dst, const __local ulong3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl3I8"))) event_t async_work_group_copy(__global ulong3 *, const __local ulong3 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl3I8"))) event_t async_work_group_copy(__global long3 *, const __local long3 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl3I8(__global ulong3 *dst, const __local ulong3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl3I8"))) event_t async_work_group_strided_copy(__global ulong3 *, const __local ulong3 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl3I8"))) event_t async_work_group_strided_copy(__global long3 *, const __local long3 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ulong3 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global long3 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local float3 * dst, const __global float3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local float3 *dst, const __global float3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global float3 * dst, const __local float3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global float3 *dst, const __local float3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global float3 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local double3 * dst, const __global double3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local double3 *dst, const __global double3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global double3 * dst, const __local double3 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global double3 *dst, const __local double3 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global double3 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg4I1(__local uchar4 * dst, const __global uchar4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg4I1"))) event_t async_work_group_copy(__local uchar4 *, const __global uchar4 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg4I1"))) event_t async_work_group_copy(__local char4 *, const __global char4 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg4I1(__local uchar4 *dst, const __global uchar4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg4I1"))) event_t async_work_group_strided_copy(__local uchar4 *, const __global uchar4 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg4I1"))) event_t async_work_group_strided_copy(__local char4 *, const __global char4 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl4I1(__global uchar4 * dst, const __local uchar4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl4I1"))) event_t async_work_group_copy(__global uchar4 *, const __local uchar4 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl4I1"))) event_t async_work_group_copy(__global char4 *, const __local char4 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl4I1(__global uchar4 *dst, const __local uchar4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl4I1"))) event_t async_work_group_strided_copy(__global uchar4 *, const __local uchar4 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl4I1"))) event_t async_work_group_strided_copy(__global char4 *, const __local char4 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uchar4 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global char4 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg4I2(__local ushort4 * dst, const __global ushort4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg4I2"))) event_t async_work_group_copy(__local ushort4 *, const __global ushort4 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg4I2"))) event_t async_work_group_copy(__local short4 *, const __global short4 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg4I2(__local ushort4 *dst, const __global ushort4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg4I2"))) event_t async_work_group_strided_copy(__local ushort4 *, const __global ushort4 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg4I2"))) event_t async_work_group_strided_copy(__local short4 *, const __global short4 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl4I2(__global ushort4 * dst, const __local ushort4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl4I2"))) event_t async_work_group_copy(__global ushort4 *, const __local ushort4 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl4I2"))) event_t async_work_group_copy(__global short4 *, const __local short4 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl4I2(__global ushort4 *dst, const __local ushort4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl4I2"))) event_t async_work_group_strided_copy(__global ushort4 *, const __local ushort4 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl4I2"))) event_t async_work_group_strided_copy(__global short4 *, const __local short4 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ushort4 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global short4 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg4I4(__local uint4 * dst, const __global uint4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg4I4"))) event_t async_work_group_copy(__local uint4 *, const __global uint4 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg4I4"))) event_t async_work_group_copy(__local int4 *, const __global int4 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg4I4(__local uint4 *dst, const __global uint4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg4I4"))) event_t async_work_group_strided_copy(__local uint4 *, const __global uint4 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg4I4"))) event_t async_work_group_strided_copy(__local int4 *, const __global int4 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl4I4(__global uint4 * dst, const __local uint4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl4I4"))) event_t async_work_group_copy(__global uint4 *, const __local uint4 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl4I4"))) event_t async_work_group_copy(__global int4 *, const __local int4 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl4I4(__global uint4 *dst, const __local uint4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl4I4"))) event_t async_work_group_strided_copy(__global uint4 *, const __local uint4 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl4I4"))) event_t async_work_group_strided_copy(__global int4 *, const __local int4 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uint4 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global int4 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg4I8(__local ulong4 * dst, const __global ulong4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg4I8"))) event_t async_work_group_copy(__local ulong4 *, const __global ulong4 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg4I8"))) event_t async_work_group_copy(__local long4 *, const __global long4 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg4I8(__local ulong4 *dst, const __global ulong4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg4I8"))) event_t async_work_group_strided_copy(__local ulong4 *, const __global ulong4 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg4I8"))) event_t async_work_group_strided_copy(__local long4 *, const __global long4 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl4I8(__global ulong4 * dst, const __local ulong4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl4I8"))) event_t async_work_group_copy(__global ulong4 *, const __local ulong4 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl4I8"))) event_t async_work_group_copy(__global long4 *, const __local long4 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl4I8(__global ulong4 *dst, const __local ulong4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl4I8"))) event_t async_work_group_strided_copy(__global ulong4 *, const __local ulong4 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl4I8"))) event_t async_work_group_strided_copy(__global long4 *, const __local long4 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ulong4 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global long4 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local float4 * dst, const __global float4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local float4 *dst, const __global float4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global float4 * dst, const __local float4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global float4 *dst, const __local float4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global float4 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local double4 * dst, const __global double4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local double4 *dst, const __global double4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global double4 * dst, const __local double4 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global double4 *dst, const __local double4 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global double4 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg8I1(__local uchar8 * dst, const __global uchar8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg8I1"))) event_t async_work_group_copy(__local uchar8 *, const __global uchar8 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg8I1"))) event_t async_work_group_copy(__local char8 *, const __global char8 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg8I1(__local uchar8 *dst, const __global uchar8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg8I1"))) event_t async_work_group_strided_copy(__local uchar8 *, const __global uchar8 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg8I1"))) event_t async_work_group_strided_copy(__local char8 *, const __global char8 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl8I1(__global uchar8 * dst, const __local uchar8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl8I1"))) event_t async_work_group_copy(__global uchar8 *, const __local uchar8 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl8I1"))) event_t async_work_group_copy(__global char8 *, const __local char8 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl8I1(__global uchar8 *dst, const __local uchar8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl8I1"))) event_t async_work_group_strided_copy(__global uchar8 *, const __local uchar8 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl8I1"))) event_t async_work_group_strided_copy(__global char8 *, const __local char8 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uchar8 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global char8 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg8I2(__local ushort8 * dst, const __global ushort8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg8I2"))) event_t async_work_group_copy(__local ushort8 *, const __global ushort8 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg8I2"))) event_t async_work_group_copy(__local short8 *, const __global short8 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg8I2(__local ushort8 *dst, const __global ushort8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg8I2"))) event_t async_work_group_strided_copy(__local ushort8 *, const __global ushort8 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg8I2"))) event_t async_work_group_strided_copy(__local short8 *, const __global short8 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl8I2(__global ushort8 * dst, const __local ushort8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl8I2"))) event_t async_work_group_copy(__global ushort8 *, const __local ushort8 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl8I2"))) event_t async_work_group_copy(__global short8 *, const __local short8 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl8I2(__global ushort8 *dst, const __local ushort8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl8I2"))) event_t async_work_group_strided_copy(__global ushort8 *, const __local ushort8 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl8I2"))) event_t async_work_group_strided_copy(__global short8 *, const __local short8 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ushort8 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global short8 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg8I4(__local uint8 * dst, const __global uint8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg8I4"))) event_t async_work_group_copy(__local uint8 *, const __global uint8 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg8I4"))) event_t async_work_group_copy(__local int8 *, const __global int8 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg8I4(__local uint8 *dst, const __global uint8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg8I4"))) event_t async_work_group_strided_copy(__local uint8 *, const __global uint8 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg8I4"))) event_t async_work_group_strided_copy(__local int8 *, const __global int8 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl8I4(__global uint8 * dst, const __local uint8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl8I4"))) event_t async_work_group_copy(__global uint8 *, const __local uint8 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl8I4"))) event_t async_work_group_copy(__global int8 *, const __local int8 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl8I4(__global uint8 *dst, const __local uint8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl8I4"))) event_t async_work_group_strided_copy(__global uint8 *, const __local uint8 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl8I4"))) event_t async_work_group_strided_copy(__global int8 *, const __local int8 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uint8 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global int8 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg8I8(__local ulong8 * dst, const __global ulong8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg8I8"))) event_t async_work_group_copy(__local ulong8 *, const __global ulong8 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg8I8"))) event_t async_work_group_copy(__local long8 *, const __global long8 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg8I8(__local ulong8 *dst, const __global ulong8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg8I8"))) event_t async_work_group_strided_copy(__local ulong8 *, const __global ulong8 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg8I8"))) event_t async_work_group_strided_copy(__local long8 *, const __global long8 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl8I8(__global ulong8 * dst, const __local ulong8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl8I8"))) event_t async_work_group_copy(__global ulong8 *, const __local ulong8 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl8I8"))) event_t async_work_group_copy(__global long8 *, const __local long8 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl8I8(__global ulong8 *dst, const __local ulong8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl8I8"))) event_t async_work_group_strided_copy(__global ulong8 *, const __local ulong8 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl8I8"))) event_t async_work_group_strided_copy(__global long8 *, const __local long8 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ulong8 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global long8 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local float8 * dst, const __global float8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local float8 *dst, const __global float8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global float8 * dst, const __local float8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global float8 *dst, const __local float8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global float8 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local double8 * dst, const __global double8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local double8 *dst, const __global double8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global double8 * dst, const __local double8 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global double8 *dst, const __local double8 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global double8 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg16I1(__local uchar16 * dst, const __global uchar16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg16I1"))) event_t async_work_group_copy(__local uchar16 *, const __global uchar16 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg16I1"))) event_t async_work_group_copy(__local char16 *, const __global char16 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg16I1(__local uchar16 *dst, const __global uchar16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg16I1"))) event_t async_work_group_strided_copy(__local uchar16 *, const __global uchar16 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg16I1"))) event_t async_work_group_strided_copy(__local char16 *, const __global char16 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl16I1(__global uchar16 * dst, const __local uchar16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl16I1"))) event_t async_work_group_copy(__global uchar16 *, const __local uchar16 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl16I1"))) event_t async_work_group_copy(__global char16 *, const __local char16 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl16I1(__global uchar16 *dst, const __local uchar16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl16I1"))) event_t async_work_group_strided_copy(__global uchar16 *, const __local uchar16 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl16I1"))) event_t async_work_group_strided_copy(__global char16 *, const __local char16 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uchar16 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global char16 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg16I2(__local ushort16 * dst, const __global ushort16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg16I2"))) event_t async_work_group_copy(__local ushort16 *, const __global ushort16 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg16I2"))) event_t async_work_group_copy(__local short16 *, const __global short16 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg16I2(__local ushort16 *dst, const __global ushort16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg16I2"))) event_t async_work_group_strided_copy(__local ushort16 *, const __global ushort16 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg16I2"))) event_t async_work_group_strided_copy(__local short16 *, const __global short16 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl16I2(__global ushort16 * dst, const __local ushort16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl16I2"))) event_t async_work_group_copy(__global ushort16 *, const __local ushort16 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl16I2"))) event_t async_work_group_copy(__global short16 *, const __local short16 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl16I2(__global ushort16 *dst, const __local ushort16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl16I2"))) event_t async_work_group_strided_copy(__global ushort16 *, const __local ushort16 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl16I2"))) event_t async_work_group_strided_copy(__global short16 *, const __local short16 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ushort16 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global short16 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg16I4(__local uint16 * dst, const __global uint16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg16I4"))) event_t async_work_group_copy(__local uint16 *, const __global uint16 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg16I4"))) event_t async_work_group_copy(__local int16 *, const __global int16 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg16I4(__local uint16 *dst, const __global uint16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg16I4"))) event_t async_work_group_strided_copy(__local uint16 *, const __global uint16 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg16I4"))) event_t async_work_group_strided_copy(__local int16 *, const __global int16 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl16I4(__global uint16 * dst, const __local uint16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl16I4"))) event_t async_work_group_copy(__global uint16 *, const __local uint16 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl16I4"))) event_t async_work_group_copy(__global int16 *, const __local int16 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl16I4(__global uint16 *dst, const __local uint16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl16I4"))) event_t async_work_group_strided_copy(__global uint16 *, const __local uint16 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl16I4"))) event_t async_work_group_strided_copy(__global int16 *, const __local int16 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global uint16 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global int16 *p, size_t n)
{
    // nothing to do
}

__attribute__((always_inline)) static event_t
__AWGClg16I8(__local ulong16 * dst, const __global ulong16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGClg16I8"))) event_t async_work_group_copy(__local ulong16 *, const __global ulong16 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGClg16I8"))) event_t async_work_group_copy(__local long16 *, const __global long16 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSClg16I8(__local ulong16 *dst, const __global ulong16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSClg16I8"))) event_t async_work_group_strided_copy(__local ulong16 *, const __global ulong16 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSClg16I8"))) event_t async_work_group_strided_copy(__local long16 *, const __global long16 *, size_t, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGCgl16I8(__global ulong16 * dst, const __local ulong16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGCgl16I8"))) event_t async_work_group_copy(__global ulong16 *, const __local ulong16 *, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGCgl16I8"))) event_t async_work_group_copy(__global long16 *, const __local long16 *, size_t, event_t);

__attribute__((always_inline)) static event_t
__AWGSCgl16I8(__global ulong16 *dst, const __local ulong16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

extern __attribute__((overloadable, weak, alias("__AWGSCgl16I8"))) event_t async_work_group_strided_copy(__global ulong16 *, const __local ulong16 *, size_t, size_t, event_t);
extern __attribute__((overloadable, weak, alias("__AWGSCgl16I8"))) event_t async_work_group_strided_copy(__global long16 *, const __local long16 *, size_t, size_t, event_t);

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global ulong16 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global long16 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local float16 * dst, const __global float16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local float16 *dst, const __global float16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global float16 * dst, const __local float16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global float16 *dst, const __local float16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global float16 *p, size_t n)
{
    // nothing to do
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__local double16 * dst, const __global double16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__local double16 *dst, const __global double16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i*j];
        i += d;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_copy(__global double16 * dst, const __local double16 * src, size_t n, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) event_t
async_work_group_strided_copy(__global double16 *dst, const __local double16 *src, size_t n, size_t j, event_t e)
{
    int4 ls = (int4)(get_local_size(0), get_local_size(1), get_local_size(2), 0);
    size_t i = __hsail_workitemid_flat();
    size_t d = ls.x * ls.y * ls.z;
    while (i < n) {
        dst[i*j] = src[i];
        i += d;
    }
    barrier(CLK_GLOBAL_MEM_FENCE);
    return e;
}

__attribute__((overloadable, always_inline, weak)) void
prefetch(const __global double16 *p, size_t n)
{
    // nothing to do
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) void
wait_group_events(int num_events, event_t *event_list)
{
    // Nothing to do
}
