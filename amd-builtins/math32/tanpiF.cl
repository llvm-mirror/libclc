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

#if !defined(SUBNORMALS_SUPPORTED)
#include "floattointconversion.h"
#endif //SUBNORMALS_SUPPORTED

static inline float2
tanf_piby4(float x)
{
    // Core Remez [1,2] approximation to tan(x) on the interval [0,pi/4]
    float r = x*x;
    float a = mad(r, -0.0172032480471481694693109f, 0.385296071263995406715129f);
    float b = mad(r, mad(r, 0.01844239256901656082986661f, -0.51396505478854532132342f),
	                                                   1.15588821434688393452299f);
    float t = mad(x*r, MATH_DIVIDE(a,b), x);
    return (float2)(t, -MATH_RECIP(t));
}

__attribute__((overloadable)) float
tanpi(float x)
{
    const float pi = 3.1415926535897932F;

    int ix = as_int(x);
    int xsgn = ix & 0x80000000;
    int xnsgn = xsgn ^ 0x80000000;
    ix ^= xsgn;
    float ax = as_float(ix);
    int iax = (int)ax;
    float r = ax - iax;
    int xodd = xsgn ^ (iax & 0x1 ? 0x80000000 : 0);

    // Initialize with return for +-Inf and NaN
    int ir = 0x7fc00000;

    // 2^24 <= |x| < Inf, the result is always even integer
    ir = ix < 0x7f800000 ? xsgn : ir;

    // 2^23 <= |x| < 2^24, the result is always integer
    ir = ix < 0x4b800000 ? xodd : ir;

    // 0x1.0p-7 <= |x| < 2^23, result depends on which 0.25 interval

    // r < 1.0
    float a = 1.0f - r;
    int e = 0;
    int s = xnsgn;

    // r <= 0.75
    int c = r <= 0.75f;
    a = c ? r - 0.5f : a;
    e = c ? 1 : e;
    s = c ? xsgn : s;

    // r < 0.5
    c = r < 0.5f;
    a = c ? 0.5f - r : a;
    s = c ? xnsgn : s;

    // 0 < r <= 0.25
    c = r <= 0.25f;
    a = c ? r : a;
    e = c ? 0 : e;
    s = c ? xsgn : s;

    float2 t = tanf_piby4(a * pi);
    int jr = s ^ as_int(e ? t.hi : t.lo);

    jr = r == 0.5f ? xodd | 0x7f800000 : jr;

    ir = ix < 0x4b000000 ? jr : ir;

#if !defined(SUBNORMALS_SUPPORTED)
	if(ax <= 0.)
	{
		double d = float_uint_to_double(as_uint(x));
		ir = (double_to_float_uint(d*pi));
	}
#endif //SUBNORMALS_SUPPORTED

    return as_float(ir);
}

