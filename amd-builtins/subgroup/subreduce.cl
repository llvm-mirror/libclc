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

#pragma OPENCL EXTENSION cl_khr_subgroups : enable

extern uint __hsail_get_lane_id(void);
extern uint __hsail_activelaneshuffle_wavewidth_b32(uint src, uint lid, uint ival, bool useival);
extern ulong __hsail_activelaneshuffle_wavewidth_b64(ulong src, uint lid, ulong ival, bool useival);
extern void __hsail_wavebarrier();

#define GENA(TY,SZ,AO,AI,Z) \
__attribute__((overloadable, always_inline)) TY \
sub_group_reduce_add(TY a) \
{ \
    uint lid = __hsail_get_lane_id(); \
    a += AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^1, AI(Z), false)); \
    __hsail_wavebarrier(); \
    a += AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^2, AI(Z), false)); \
    __hsail_wavebarrier(); \
    a += AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^4, AI(Z), false)); \
    __hsail_wavebarrier(); \
    a += AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^8, AI(Z), false)); \
    __hsail_wavebarrier(); \
    a += AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^16, AI(Z), false)); \
    __hsail_wavebarrier(); \
    a += AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^32, AI(Z), false)); \
    __hsail_wavebarrier(); \
    return a; \
}

GENA(int,32,as_int,as_uint,0)
GENA(uint,32,,,0U)
GENA(long,64,as_long,as_ulong,0L)
GENA(ulong,64,,,0UL)
GENA(float,32,as_float,as_uint,0.0f)
GENA(double,64,as_double,as_ulong,0.0)

#define GENO(TY,SZ,OP,AO,AI,ID) \
__attribute__((overloadable, always_inline)) TY \
sub_group_reduce_##OP(TY a) \
{ \
    uint lid = __hsail_get_lane_id(); \
    a = OP(a, AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^1, AI(ID), false))); \
    __hsail_wavebarrier(); \
    a = OP(a, AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^2, AI(ID), false))); \
    __hsail_wavebarrier(); \
    a = OP(a, AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^4, AI(ID), false))); \
    __hsail_wavebarrier(); \
    a = OP(a, AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^8, AI(ID), false))); \
    __hsail_wavebarrier(); \
    a = OP(a, AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^16, AI(ID), false))); \
    __hsail_wavebarrier(); \
    a = OP(a, AO(__hsail_activelaneshuffle_wavewidth_b##SZ(AI(a), lid^32, AI(ID), false))); \
    __hsail_wavebarrier(); \
    return a; \
}

GENO(int,32,min,as_int,as_uint,INT_MAX)
GENO(uint,32,min,,,UINT_MAX)
GENO(long,64,min,as_long,as_ulong,LONG_MAX)
GENO(ulong,64,min,,,ULONG_MAX)
GENO(float,32,min,as_float,as_uint,INFINITY)
GENO(double,64,min,as_double,as_ulong,(double)INFINITY)

GENO(int,32,max,as_int,as_uint,INT_MIN)
GENO(uint,32,max,,,0U)
GENO(long,64,max,as_long,as_ulong,LONG_MIN)
GENO(ulong,64,max,,,0UL)
GENO(float,32,max,as_float,as_uint,-INFINITY)
GENO(double,64,max,as_double,as_ulong,-(double)INFINITY)

#endif

