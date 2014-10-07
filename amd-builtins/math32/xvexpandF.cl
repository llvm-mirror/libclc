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

// XXX this file can be removed after clp is implemented

__attribute__((overloadable, always_inline, weak)) float16
fract(float16 x, float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float16
fract(float16 x, __global float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float16
fract(float16 x, __local float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float8
fract(float8 x, float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float8
fract(float8 x, __global float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float8
fract(float8 x, __local float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float4
fract(float4 x, float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float4
fract(float4 x, __global float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float4
fract(float4 x, __local float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float3
fract(float3 x, float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = fract(x.s01, &a);
    t.s01 = a;
    r.s2 = fract(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float3
fract(float3 x, __global float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = fract(x.s01, &a);
    t.s01 = a;
    r.s2 = fract(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float3
fract(float3 x, __local float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = fract(x.s01, &a);
    t.s01 = a;
    r.s2 = fract(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float2
fract(float2 x, float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float2
fract(float2 x, __global float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float2
fract(float2 x, __local float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float16
modf(float16 x, float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float16
modf(float16 x, __global float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float16
modf(float16 x, __local float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float8
modf(float8 x, float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float8
modf(float8 x, __global float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float8
modf(float8 x, __local float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float4
modf(float4 x, float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float4
modf(float4 x, __global float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float4
modf(float4 x, __local float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float3
modf(float3 x, float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = modf(x.s01, &a);
    t.s01 = a;
    r.s2 = modf(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float3
modf(float3 x, __global float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = modf(x.s01, &a);
    t.s01 = a;
    r.s2 = modf(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float3
modf(float3 x, __local float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = modf(x.s01, &a);
    t.s01 = a;
    r.s2 = modf(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float2
modf(float2 x, float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float2
modf(float2 x, __global float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float2
modf(float2 x, __local float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float16
sincos(float16 x, float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float16
sincos(float16 x, __global float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float16
sincos(float16 x, __local float16 *p)
{
    float16 r;
    float16 t;
    float8 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float8
sincos(float8 x, float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float8
sincos(float8 x, __global float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float8
sincos(float8 x, __local float8 *p)
{
    float8 r;
    float8 t;
    float4 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float4
sincos(float4 x, float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float4
sincos(float4 x, __global float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float4
sincos(float4 x, __local float4 *p)
{
    float4 r;
    float4 t;
    float2 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float3
sincos(float3 x, float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = sincos(x.s01, &a);
    t.s01 = a;
    r.s2 = sincos(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float3
sincos(float3 x, __global float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = sincos(x.s01, &a);
    t.s01 = a;
    r.s2 = sincos(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float3
sincos(float3 x, __local float3 *p)
{
    float3 r;
    float3 t;
    float2 a;
    float b;

    r.s01 = sincos(x.s01, &a);
    t.s01 = a;
    r.s2 = sincos(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) float2
sincos(float2 x, float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float2
sincos(float2 x, __global float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) float2
sincos(float2 x, __local float2 *p)
{
    float2 r;
    float2 t;
    float a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

