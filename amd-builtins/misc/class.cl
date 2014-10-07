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
#define SNAN 0x001
#define QNAN 0x002
#define NINF 0x004
#define NNOR 0x008
#define NSUB 0x010
#define NZER 0x020
#define PZER 0x040
#define PSUB 0x080
#define PNOR 0x100
#define PINF 0x200

extern __attribute__((pure)) int __amdil_class_f32(float, int);
extern __attribute__((pure)) int __amdil_class_f64(double, int);

#define FC(F,M) \
__attribute__((overloadable, always_inline)) int \
F(float x) \
{ \
    return __amdil_class_f32(x, M) & 1; \
} \
__attribute__((overloadable, always_inline)) int2 \
F(float2 x) \
{ \
    int2 ret; \
    ret.s0 = __amdil_class_f32(x.s0, M); \
    ret.s1 = __amdil_class_f32(x.s1, M); \
    return ret; \
} \
__attribute__((overloadable, always_inline)) int3 \
F(float3 x) \
{ \
    int3 ret; \
    ret.s0 = __amdil_class_f32(x.s0, M); \
    ret.s1 = __amdil_class_f32(x.s1, M); \
    ret.s2 = __amdil_class_f32(x.s2, M); \
    return ret; \
} \
__attribute__((overloadable, always_inline)) int4 \
F(float4 x) \
{ \
    int4 ret; \
    ret.s0 = __amdil_class_f32(x.s0, M); \
    ret.s1 = __amdil_class_f32(x.s1, M); \
    ret.s2 = __amdil_class_f32(x.s2, M); \
    ret.s3 = __amdil_class_f32(x.s3, M); \
    return ret; \
} \
__attribute__((overloadable, always_inline)) int8 \
F(float8 x) \
{ \
    int8 ret; \
    ret.s0 = __amdil_class_f32(x.s0, M); \
    ret.s1 = __amdil_class_f32(x.s1, M); \
    ret.s2 = __amdil_class_f32(x.s2, M); \
    ret.s3 = __amdil_class_f32(x.s3, M); \
    ret.s4 = __amdil_class_f32(x.s4, M); \
    ret.s5 = __amdil_class_f32(x.s5, M); \
    ret.s6 = __amdil_class_f32(x.s6, M); \
    ret.s7 = __amdil_class_f32(x.s7, M); \
    return ret; \
} \
__attribute__((overloadable, always_inline)) int16 \
F(float16 x) \
{ \
    int16 ret; \
    ret.s0 = __amdil_class_f32(x.s0, M); \
    ret.s1 = __amdil_class_f32(x.s1, M); \
    ret.s2 = __amdil_class_f32(x.s2, M); \
    ret.s3 = __amdil_class_f32(x.s3, M); \
    ret.s4 = __amdil_class_f32(x.s4, M); \
    ret.s5 = __amdil_class_f32(x.s5, M); \
    ret.s6 = __amdil_class_f32(x.s6, M); \
    ret.s7 = __amdil_class_f32(x.s7, M); \
    ret.s8 = __amdil_class_f32(x.s8, M); \
    ret.s9 = __amdil_class_f32(x.s9, M); \
    ret.sa = __amdil_class_f32(x.sa, M); \
    ret.sb = __amdil_class_f32(x.sb, M); \
    ret.sc = __amdil_class_f32(x.sc, M); \
    ret.sd = __amdil_class_f32(x.sd, M); \
    ret.se = __amdil_class_f32(x.se, M); \
    ret.sf = __amdil_class_f32(x.sf, M); \
    return ret; \
}


#define DC(F,M) \
__attribute__((overloadable, always_inline)) int \
F(double x) \
{ \
    return __amdil_class_f64(x, M) & 1; \
} \
__attribute__((overloadable, always_inline)) long2 \
F(double2 x) \
{ \
    long2 ret; \
    ret.s0 = __amdil_class_f64(x.s0, M); \
    ret.s1 = __amdil_class_f64(x.s1, M); \
    return ret; \
} \
__attribute__((overloadable, always_inline)) long3 \
F(double3 x) \
{ \
    long3 ret; \
    ret.s0 = __amdil_class_f64(x.s0, M); \
    ret.s1 = __amdil_class_f64(x.s1, M); \
    ret.s2 = __amdil_class_f64(x.s2, M); \
    return ret; \
} \
__attribute__((overloadable, always_inline)) long4 \
F(double4 x) \
{ \
    long4 ret; \
    ret.s0 = __amdil_class_f64(x.s0, M); \
    ret.s1 = __amdil_class_f64(x.s1, M); \
    ret.s2 = __amdil_class_f64(x.s2, M); \
    ret.s3 = __amdil_class_f64(x.s3, M); \
    return ret; \
} \
__attribute__((overloadable, always_inline)) long8 \
F(double8 x) \
{ \
    long8 ret; \
    ret.s0 = __amdil_class_f64(x.s0, M); \
    ret.s1 = __amdil_class_f64(x.s1, M); \
    ret.s2 = __amdil_class_f64(x.s2, M); \
    ret.s3 = __amdil_class_f64(x.s3, M); \
    ret.s4 = __amdil_class_f64(x.s4, M); \
    ret.s5 = __amdil_class_f64(x.s5, M); \
    ret.s6 = __amdil_class_f64(x.s6, M); \
    ret.s7 = __amdil_class_f64(x.s7, M); \
    return ret; \
} \
__attribute__((overloadable, always_inline)) long16 \
F(double16 x) \
{ \
    long16 ret; \
    ret.s0 = __amdil_class_f64(x.s0, M); \
    ret.s1 = __amdil_class_f64(x.s1, M); \
    ret.s2 = __amdil_class_f64(x.s2, M); \
    ret.s3 = __amdil_class_f64(x.s3, M); \
    ret.s4 = __amdil_class_f64(x.s4, M); \
    ret.s5 = __amdil_class_f64(x.s5, M); \
    ret.s6 = __amdil_class_f64(x.s6, M); \
    ret.s7 = __amdil_class_f64(x.s7, M); \
    ret.s8 = __amdil_class_f64(x.s8, M); \
    ret.s9 = __amdil_class_f64(x.s9, M); \
    ret.sa = __amdil_class_f64(x.sa, M); \
    ret.sb = __amdil_class_f64(x.sb, M); \
    ret.sc = __amdil_class_f64(x.sc, M); \
    ret.sd = __amdil_class_f64(x.sd, M); \
    ret.se = __amdil_class_f64(x.se, M); \
    ret.sf = __amdil_class_f64(x.sf, M); \
    return ret; \
}

FC(isfinite, (NNOR|NSUB|NZER|PZER|PSUB|PNOR))
FC(isinf, (NINF|PINF))
FC(isnan, (SNAN|QNAN))
FC(isnormal, (NNOR|PNOR))

DC(isfinite, (NNOR|NSUB|NZER|PZER|PSUB|PNOR))
DC(isinf, (NINF|PINF))
DC(isnan, (SNAN|QNAN))
DC(isnormal, (NNOR|PNOR))

