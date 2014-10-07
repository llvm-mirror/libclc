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
#include "sincospiF_piby4.h"
#if !defined(SUBNORMALS_SUPPORTED)
#include "floattointconversion.h"
#endif //SUBNORMALS_SUPPORTED


__attribute__((overloadable)) float
sinpi(float x)
{
    const float pi = 3.1415926535897932F;

    int ix = as_int(x);
    int xsgn = ix & 0x80000000;
    ix ^= xsgn;
    float ax = as_float(ix);
    int iax = (int)ax;
    float r = ax - iax;
    int xodd = xsgn ^ (iax & 0x1 ? 0x80000000 : 0);

    // Initialize with return for +-Inf and NaN
    int ir = 0x7fc00000;

    // 2^23 <= |x| < Inf, the result is always integer
    ir = ix < 0x7f800000 ? xsgn : ir;

    // 0x1.0p-7 <= |x| < 2^23, result depends on which 0.25 interval

    // r < 1.0
    float a = 1.0f - r;
    int e = 0;

    // r <= 0.75
    int c = r <= 0.75f;
    a = c ? r - 0.5f : a;
    e = c ? 1 : e;

    // r < 0.5
    c = r < 0.5f;
    a = c ? 0.5f - r : a;

    // 0 < r <= 0.25
    c = r <= 0.25f;
    a = c ? r : a;
    e = c ? 0 : e;

    float2 t = sincosf_piby4(a * pi);
    int jr = xodd ^ as_int(e ? t.hi : t.lo);

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

