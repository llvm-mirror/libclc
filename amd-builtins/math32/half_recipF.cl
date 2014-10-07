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

extern __attribute__((pure)) float __amdil_div_f32(float,float);
//extern __attribute__((pure)) float2 __amdil_div_v2f32(float2,float2);
//extern __attribute__((pure)) float4 __amdil_div_v4f32(float4,float4);

__attribute__((overloadable, always_inline)) float
half_recip(float x)
{
    return __amdil_div_f32(1.0f, x);
}

//__attribute__((overloadable, always_inline)) float2
//half_recip(float2 x)
//{
//    return __amdil_div_v2f32((float2)1.0f, x);
//}
//
//__attribute__((overloadable, always_inline)) float3
//half_recip(float3 x)
//{
//    float3 ret;
//    ret.s01 =  __amdil_div_v2f32((float2)1.0f, x.s01);
//    ret.s2 = __amdil_div_f32(1.0f, x.s2);
//    return ret;
//}
//
//__attribute__((overloadable, always_inline)) float4
//half_recip(float4 x)
//{
//    return __amdil_div_v4f32((float4)1.0f, x);
//}

