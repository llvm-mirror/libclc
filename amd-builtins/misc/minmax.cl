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
//#define G(F,T,N) \
//__attribute__((overloadable, always_inline)) T##N \
//F(T##N x, T##N y) \
//{ \
//    T##N ret; \
//    ret.lo = F(x.lo, y.lo); \
//    ret.hi = F(x.hi, y.hi); \
//    return ret; \
//}
//
//G(min,float,16)
//G(min,float,8)

//__attribute__((overloadable, always_inline)) float4
//min(float4 x, float4 y)
//{
//    return __amdil_min_v4f32(x, y);
//}
//
//__attribute__((overloadable, always_inline)) float3
//min(float3 x, float3 y)
//{
//#if defined VEC3_BACKEND
//    return __amdil_min_v3f32(x, y);
//#else
//    float3 ret;
//    ret.xy = min(x.xy, y.xy);
//    ret.z = min(x.z, y.z);
//    return ret;
//#endif
//}
//
//__attribute__((overloadable, always_inline)) float2
//min(float2 x, float2 y)
//{
//    return __amdil_min_v2f32(x, y);
//}

extern __attribute__((pure)) float __hsail_min_f32(float,float);

__attribute__((weak, overloadable, always_inline)) float
min(float x, float y)
{
    return __hsail_min_f32(x, y);
}

//G(min,double,16)
//G(min,double,8)
//G(min,double,4)
//G(min,double,3)
//G(min,double,2)

extern __attribute__((pure)) double __hsail_min_f64(double,double);

__attribute__((weak, overloadable, always_inline)) double
min(double x, double y)
{
    return __hsail_min_f64(x, y);
}

//G(max,float,16)
//G(max,float,8)
//
//__attribute__((overloadable, always_inline)) float4
//max(float4 x, float4 y)
//{
//    return __amdil_max_v4f32(x, y);
//}
//
//__attribute__((overloadable, always_inline)) float3
//max(float3 x, float3 y)
//{
//#if defined VEC3_BACKEND
//    return __amdil_max_v3f32(x, y);
//#else
//    float3 ret;
//    ret.xy = max(x.xy, y.xy);
//    ret.z = max(x.z, y.z);
//    return ret;
//#endif
//}
//
//__attribute__((overloadable, always_inline)) float2
//max(float2 x, float2 y)
//{
//    return __amdil_max_v2f32(x, y);
//}

extern __attribute__((pure)) float __hsail_max_f32(float,float);

__attribute__((weak, overloadable, always_inline)) float
max(float x, float y)
{
    return __hsail_max_f32(x, y);
}

//G(max,double,16)
//G(max,double,8)
//G(max,double,4)
//G(max,double,3)
//G(max,double,2)

extern __attribute__((pure)) double __hsail_max_f64(double,double);

__attribute__((weak, overloadable, always_inline)) double
max(double x, double y)
{
    return __hsail_max_f64(x, y);
}
