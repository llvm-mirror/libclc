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

extern float __amdil_half_to_float_f32(uint op1);

extern float __amdil_float_to_half_f32(float op1);
extern float __amdil_float_to_half_near_f32(float op1);
extern float __amdil_float_to_half_neg_inf_f32(float op1);
extern float __amdil_float_to_half_plus_inf_f32(float op1);

// half -> float
__attribute__((always_inline)) float
__cvt_f16_to_f32(ushort a)
{
    return __amdil_half_to_float_f32((uint)a);
}

__attribute__((always_inline)) float2
__cvt_2f16_to_2f32(ushort2 ush)
{
    float2 ret;
    ret.s0 = __cvt_f16_to_f32(ush.s0);
    ret.s1 = __cvt_f16_to_f32(ush.s1);
    return ret;
}

__attribute__((always_inline)) float3
__cvt_3f16_to_3f32(ushort3 ush)
{
    float3 ret;
    ret.lo = __cvt_2f16_to_2f32(ush.lo);
    ret.s2 = __cvt_f16_to_f32(ush.s2);
    return ret;
}

__attribute__((always_inline)) float4
__cvt_4f16_to_4f32(ushort4 ush)
{
    float4 ret;
    ret.lo = __cvt_2f16_to_2f32(ush.lo);
    ret.hi = __cvt_2f16_to_2f32(ush.hi);
    return ret;
}

__attribute__((always_inline)) float8
__cvt_8f16_to_8f32(ushort8 ush)
{
    float8 ret;
    ret.lo = __cvt_4f16_to_4f32(ush.lo);
    ret.hi = __cvt_4f16_to_4f32(ush.hi);
    return ret;
}

__attribute__((always_inline)) float16
__cvt_16f16_to_16f32(ushort16 ush)
{
    float16 ret;
    ret.lo = __cvt_8f16_to_8f32(ush.lo);
    ret.hi = __cvt_8f16_to_8f32(ush.hi);
    return ret;
}

// float -> half rte
__attribute__((always_inline)) ushort
__cvt_f32_to_f16_rte(float a)
{
    return (ushort)as_uint(__amdil_float_to_half_near_f32(a));
}

__attribute__((always_inline)) ushort2
__cvt_2f32_to_2f16_rte(float2 f)
{
    ushort2 ret;
    ret.s0 = __cvt_f32_to_f16_rte(f.s0);
    ret.s1 = __cvt_f32_to_f16_rte(f.s1);
    return ret;
}

__attribute__((always_inline)) ushort3
__cvt_3f32_to_3f16_rte(float3 f)
{
    ushort3 ret;
    ret.lo = __cvt_2f32_to_2f16_rte(f.lo);
    ret.s2 = __cvt_f32_to_f16_rte(f.s2);
    return ret;
}

__attribute__((always_inline)) ushort4
__cvt_4f32_to_4f16_rte(float4 f)
{
    ushort4 ret;
    ret.lo = __cvt_2f32_to_2f16_rte(f.lo);
    ret.hi = __cvt_2f32_to_2f16_rte(f.hi);
    return ret;
}

__attribute__((always_inline)) ushort8
__cvt_8f32_to_8f16_rte(float8 f)
{
    ushort8 ret;
    ret.lo = __cvt_4f32_to_4f16_rte(f.lo);
    ret.hi = __cvt_4f32_to_4f16_rte(f.hi);
    return ret;
}

__attribute__((always_inline)) ushort16
__cvt_16f32_to_16f16_rte(float16 f)
{
    ushort16 ret;
    ret.lo = __cvt_8f32_to_8f16_rte(f.lo);
    ret.hi = __cvt_8f32_to_8f16_rte(f.hi);
    return ret;
}

// float -> half cur
// XXX assumes RTE
__attribute__((always_inline)) ushort
__cvt_f32_to_f16_cur(float f)
{
    return __cvt_f32_to_f16_rte(f);
}

__attribute__((always_inline)) ushort2
__cvt_2f32_to_2f16_cur(float2 f)
{
    return __cvt_2f32_to_2f16_rte(f);
}

__attribute__((always_inline)) ushort3
__cvt_3f32_to_3f16_cur(float3 f)
{
    return __cvt_3f32_to_3f16_rte(f);
}

__attribute__((always_inline)) ushort4
__cvt_4f32_to_4f16_cur(float4 f)
{
    return __cvt_4f32_to_4f16_rte(f);
}

__attribute__((always_inline)) ushort8
__cvt_8f32_to_8f16_cur(float8 f)
{
    return __cvt_8f32_to_8f16_rte(f);
}

__attribute__((always_inline)) ushort16
__cvt_16f32_to_16f16_cur(float16 f)
{
    return __cvt_16f32_to_16f16_rte(f);
}

//float -> half rtp

ushort
__cvt_f32_to_f16_rtp(float a)
{
    return (ushort)as_uint(__amdil_float_to_half_plus_inf_f32(a));
}

__attribute__((always_inline)) ushort2
__cvt_2f32_to_2f16_rtp(float2 f)
{
    ushort2 ret;
    ret.s0 = __cvt_f32_to_f16_rtp(f.s0);
    ret.s1 = __cvt_f32_to_f16_rtp(f.s1);
    return ret;
}

__attribute__((always_inline)) ushort3
__cvt_3f32_to_3f16_rtp(float3 f)
{
    ushort3 ret;
    ret.lo = __cvt_2f32_to_2f16_rtp(f.lo);
    ret.s2 = __cvt_f32_to_f16_rtp(f.s2);
    return ret;
}

__attribute__((always_inline)) ushort4
__cvt_4f32_to_4f16_rtp(float4 f)
{
    ushort4 ret;
    ret.lo = __cvt_2f32_to_2f16_rtp(f.lo);
    ret.hi = __cvt_2f32_to_2f16_rtp(f.hi);
    return ret;
}

__attribute__((always_inline)) ushort8
__cvt_8f32_to_8f16_rtp(float8 f)
{
    ushort8 ret;
    ret.lo = __cvt_4f32_to_4f16_rtp(f.lo);
    ret.hi = __cvt_4f32_to_4f16_rtp(f.hi);
    return ret;
}

__attribute__((always_inline)) ushort16
__cvt_16f32_to_16f16_rtp(float16 f)
{
    ushort16 ret;
    ret.lo = __cvt_8f32_to_8f16_rtp(f.lo);
    ret.hi = __cvt_8f32_to_8f16_rtp(f.hi);
    return ret;
}

// float -> half rtn

ushort
__cvt_f32_to_f16_rtn(float a)
{
    return (ushort)as_uint(__amdil_float_to_half_neg_inf_f32(a));
}

__attribute__((always_inline)) ushort2
__cvt_2f32_to_2f16_rtn(float2 f)
{
    ushort2 ret;
    ret.s0 = __cvt_f32_to_f16_rtn(f.s0);
    ret.s1 = __cvt_f32_to_f16_rtn(f.s1);
    return ret;
}

__attribute__((always_inline)) ushort3
__cvt_3f32_to_3f16_rtn(float3 f)
{
    ushort3 ret;
    ret.lo = __cvt_2f32_to_2f16_rtn(f.lo);
    ret.s2 = __cvt_f32_to_f16_rtn(f.s2);
    return ret;
}

__attribute__((always_inline)) ushort4
__cvt_4f32_to_4f16_rtn(float4 f)
{
    ushort4 ret;
    ret.lo = __cvt_2f32_to_2f16_rtn(f.lo);
    ret.hi = __cvt_2f32_to_2f16_rtn(f.hi);
    return ret;
}

__attribute__((always_inline)) ushort8
__cvt_8f32_to_8f16_rtn(float8 f)
{
    ushort8 ret;
    ret.lo = __cvt_4f32_to_4f16_rtn(f.lo);
    ret.hi = __cvt_4f32_to_4f16_rtn(f.hi);
    return ret;
}

__attribute__((always_inline)) ushort16
__cvt_16f32_to_16f16_rtn(float16 f)
{
    ushort16 ret;
    ret.lo = __cvt_8f32_to_8f16_rtn(f.lo);
    ret.hi = __cvt_8f32_to_8f16_rtn(f.hi);
    return ret;
}

// float -> half rtz

ushort
__cvt_f32_to_f16_rtz(float a)
{
    return (ushort)as_uint(__amdil_float_to_half_f32(a));
}

__attribute__((always_inline)) ushort2
__cvt_2f32_to_2f16_rtz(float2 f)
{
    ushort2 ret;
    ret.s0 = __cvt_f32_to_f16_rtz(f.s0);
    ret.s1 = __cvt_f32_to_f16_rtz(f.s1);
    return ret;
}

__attribute__((always_inline)) ushort3
__cvt_3f32_to_3f16_rtz(float3 f)
{
    ushort3 ret;
    ret.lo = __cvt_2f32_to_2f16_rtz(f.lo);
    ret.s2 = __cvt_f32_to_f16_rtz(f.s2);
    return ret;
}

__attribute__((always_inline)) ushort4
__cvt_4f32_to_4f16_rtz(float4 f)
{
    ushort4 ret;
    ret.lo = __cvt_2f32_to_2f16_rtz(f.lo);
    ret.hi = __cvt_2f32_to_2f16_rtz(f.hi);
    return ret;
}

__attribute__((always_inline)) ushort8
__cvt_8f32_to_8f16_rtz(float8 f)
{
    ushort8 ret;
    ret.lo = __cvt_4f32_to_4f16_rtz(f.lo);
    ret.hi = __cvt_4f32_to_4f16_rtz(f.hi);
    return ret;
}

__attribute__((always_inline)) ushort16
__cvt_16f32_to_16f16_rtz(float16 f)
{
    ushort16 ret;
    ret.lo = __cvt_8f32_to_8f16_rtz(f.lo);
    ret.hi = __cvt_8f32_to_8f16_rtz(f.hi);
    return ret;
}

