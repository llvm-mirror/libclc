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

// XXX this file can be removed when clp is implemented

__attribute__((overloadable, always_inline, weak)) double16
fract(double16 x, double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
fract(double16 x, __global double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
fract(double16 x, __local double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double8
fract(double8 x, double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
fract(double8 x, __global double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
fract(double8 x, __local double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double4
fract(double4 x, double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
fract(double4 x, __global double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
fract(double4 x, __local double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double3
fract(double3 x, double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = fract(x.s01, &a);
    t.s01 = a;
    r.s2 = fract(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
fract(double3 x, __global double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = fract(x.s01, &a);
    t.s01 = a;
    r.s2 = fract(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
fract(double3 x, __local double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = fract(x.s01, &a);
    t.s01 = a;
    r.s2 = fract(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double2
fract(double2 x, double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
fract(double2 x, __global double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
fract(double2 x, __local double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = fract(x.lo, &a);
    t.lo = a;
    r.hi = fract(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double16
modf(double16 x, double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
modf(double16 x, __global double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
modf(double16 x, __local double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double8
modf(double8 x, double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
modf(double8 x, __global double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
modf(double8 x, __local double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double4
modf(double4 x, double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
modf(double4 x, __global double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
modf(double4 x, __local double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double3
modf(double3 x, double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = modf(x.s01, &a);
    t.s01 = a;
    r.s2 = modf(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
modf(double3 x, __global double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = modf(x.s01, &a);
    t.s01 = a;
    r.s2 = modf(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
modf(double3 x, __local double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = modf(x.s01, &a);
    t.s01 = a;
    r.s2 = modf(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double2
modf(double2 x, double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
modf(double2 x, __global double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
modf(double2 x, __local double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = modf(x.lo, &a);
    t.lo = a;
    r.hi = modf(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double16
sincos(double16 x, double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
sincos(double16 x, __global double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double16
sincos(double16 x, __local double16 *p)
{
    double16 r;
    double16 t;
    double8 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double8
sincos(double8 x, double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
sincos(double8 x, __global double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double8
sincos(double8 x, __local double8 *p)
{
    double8 r;
    double8 t;
    double4 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double4
sincos(double4 x, double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
sincos(double4 x, __global double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double4
sincos(double4 x, __local double4 *p)
{
    double4 r;
    double4 t;
    double2 a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double3
sincos(double3 x, double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = sincos(x.s01, &a);
    t.s01 = a;
    r.s2 = sincos(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
sincos(double3 x, __global double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = sincos(x.s01, &a);
    t.s01 = a;
    r.s2 = sincos(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double3
sincos(double3 x, __local double3 *p)
{
    double3 r;
    double3 t;
    double2 a;
    double b;

    r.s01 = sincos(x.s01, &a);
    t.s01 = a;
    r.s2 = sincos(x.s2, &b);
    t.s2 = b;

    *p = t;
    return r;
}

#endif

__attribute__((overloadable, always_inline, weak)) double2
sincos(double2 x, double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
sincos(double2 x, __global double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif

#ifndef __clang__

__attribute__((overloadable, always_inline, weak)) double2
sincos(double2 x, __local double2 *p)
{
    double2 r;
    double2 t;
    double a;
    

    r.lo = sincos(x.lo, &a);
    t.lo = a;
    r.hi = sincos(x.hi, &a);
    t.hi = a;

    *p = t;
    return r;
}

#endif
