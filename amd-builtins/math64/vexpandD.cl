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

__attribute__((overloadable, always_inline, weak)) double16
frexp(double16 x, int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
frexp(double16 x, __global int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
frexp(double16 x, __local int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double8
frexp(double8 x, int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
frexp(double8 x, __global int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
frexp(double8 x, __local int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double4
frexp(double4 x, int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
frexp(double4 x, __global int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
frexp(double4 x, __local int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double3
frexp(double3 x, int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = frexp(x.s01, &j);
    i.s01 = j;
    r.s2 = frexp(x.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
frexp(double3 x, __global int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = frexp(x.s01, &j);
    i.s01 = j;
    r.s2 = frexp(x.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
frexp(double3 x, __local int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = frexp(x.s01, &j);
    i.s01 = j;
    r.s2 = frexp(x.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double2
frexp(double2 x, int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
frexp(double2 x, __global int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
frexp(double2 x, __local int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = frexp(x.lo, &j);
    i.lo = j;
    r.hi = frexp(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double16
lgamma_r(double16 x, int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
lgamma_r(double16 x, __global int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
lgamma_r(double16 x, __local int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double8
lgamma_r(double8 x, int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
lgamma_r(double8 x, __global int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
lgamma_r(double8 x, __local int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double4
lgamma_r(double4 x, int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
lgamma_r(double4 x, __global int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
lgamma_r(double4 x, __local int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double3
lgamma_r(double3 x, int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = lgamma_r(x.s01, &j);
    i.s01 = j;
    r.s2 = lgamma_r(x.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
lgamma_r(double3 x, __global int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = lgamma_r(x.s01, &j);
    i.s01 = j;
    r.s2 = lgamma_r(x.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
lgamma_r(double3 x, __local int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = lgamma_r(x.s01, &j);
    i.s01 = j;
    r.s2 = lgamma_r(x.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double2
lgamma_r(double2 x, int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
lgamma_r(double2 x, __global int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
lgamma_r(double2 x, __local int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = lgamma_r(x.lo, &j);
    i.lo = j;
    r.hi = lgamma_r(x.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double16
remquo(double16 x, double16 y, int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
remquo(double16 x, double16 y, __global int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
remquo(double16 x, double16 y, __local int16 *p)
{
    double16 r;
    int16 i;
    int8 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double8
remquo(double8 x, double8 y, int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
remquo(double8 x, double8 y, __global int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
remquo(double8 x, double8 y, __local int8 *p)
{
    double8 r;
    int8 i;
    int4 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double4
remquo(double4 x, double4 y, int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
remquo(double4 x, double4 y, __global int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
remquo(double4 x, double4 y, __local int4 *p)
{
    double4 r;
    int4 i;
    int2 j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double3
remquo(double3 x, double3 y, int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = remquo(x.s01, y.s01, &j);
    i.s01 = j;
    r.s2 = remquo(x.s2, y.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
remquo(double3 x, double3 y, __global int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = remquo(x.s01, y.s01, &j);
    i.s01 = j;
    r.s2 = remquo(x.s2, y.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
remquo(double3 x, double3 y, __local int3 *p)
{
    double3 r;
    int3 i;
    int2 j;
    int k;

    r.s01 = remquo(x.s01, y.s01, &j);
    i.s01 = j;
    r.s2 = remquo(x.s2, y.s2, &k);
    i.s2 = k;

    *p = i;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double2
remquo(double2 x, double2 y, int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
remquo(double2 x, double2 y, __global int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
remquo(double2 x, double2 y, __local int2 *p)
{
    double2 r;
    int2 i;
    int j;
    

    r.lo = remquo(x.lo, y.lo, &j);
    i.lo = j;
    r.hi = remquo(x.hi, y.hi, &j);
    i.hi = j;

    *p = i;
    return r;
}

#endif

