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

#include "math32.h"

extern __attribute__((pure)) float __hsail_sqrt_ftz_f32(float);

__attribute__((always_inline, weak)) float
__precise_fp32_sqrt_f32(float x)
{
    return __hsail_sqrt_ftz_f32(x);
}


__attribute__((always_inline, weak)) float2
__precise_fp32_sqrt_2f32(float2 x)
{
    float2 ret;
    ret.lo = __precise_fp32_sqrt_f32(x.lo);
    ret.hi = __precise_fp32_sqrt_f32(x.hi);
    return ret;
}

__attribute__((always_inline, weak)) float3
__precise_fp32_sqrt_3f32(float3 x)
{
    float3 ret;
    ret.xy = __precise_fp32_sqrt_2f32(x.xy);
    ret.z = __precise_fp32_sqrt_f32(x.z);
    return ret;
}

__attribute__((always_inline, weak)) float4
__precise_fp32_sqrt_4f32(float4 x)
{
    float4 ret;
    ret.lo = __precise_fp32_sqrt_2f32(x.lo);
    ret.hi = __precise_fp32_sqrt_2f32(x.hi);
    return ret;
}

__attribute__((always_inline, weak)) float8
__precise_fp32_sqrt_8f32(float8 x)
{
    float8 ret;
    ret.lo = __precise_fp32_sqrt_4f32(x.lo);
    ret.hi = __precise_fp32_sqrt_4f32(x.hi);
    return ret;
}

__attribute__((always_inline, weak)) float16
__precise_fp32_sqrt_16f32(float16 x)
{
    float16 ret;
    ret.s0123 = __precise_fp32_sqrt_4f32(x.s0123);
    ret.s4567 = __precise_fp32_sqrt_4f32(x.s4567);
    ret.s89ab = __precise_fp32_sqrt_4f32(x.s89ab);
    ret.scdef = __precise_fp32_sqrt_4f32(x.scdef);
    return ret;
}
