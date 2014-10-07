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

#include "math64.h"
#include "tanD_piby4.h"

__attribute__((overloadable)) double
tanpi(double x)
{
    const double pi = 3.1415926535897932384626433832795;

    long ix = as_long(x); 
    long xsgn = ix & 0x8000000000000000L;
    long xnsgn = xsgn ^ 0x8000000000000000L;
    ix ^= xsgn;
    double ax = as_double(ix);
    long iax = (long)ax;
    double r = ax - iax;
    long xodd = xsgn ^ (iax & 0x1 ? 0x8000000000000000L : 0L);

    // Initialize with return for +-Inf and NaN
    long ir = 0x7ff8000000000000L;

    // 2^53 <= |x| < Inf, the result is always even integer
    ir = ix < 0x7ff0000000000000L ? xsgn : ir;

    // 2^52 <= |x| < 2^53, the result is always integer
    ir = ix < 0x4340000000000000L ? xodd : ir;

    // 0x1.0p-14 <= |x| < 2^53, result depends on which 0.25 interval

    // r < 1.0
    double a = 1.0 - r;
    int e = 0;
    long s = xnsgn;

    // r <= 0.75
    int c = r <= 0.75;
    double t = r - 0.5;
    a = c ? t : a;
    e = c ? 1 : e;
    s = c ? xsgn : s;

    // r < 0.5
    c = r < 0.5;
    t = 0.5 - r;
    a = c ? t : a;
    s = c ? xnsgn : s;

    // r <= 0.25
    c = r <= 0.25;
    a = c ? r : a;
    e = c ? 0 : e;
    s = c ? xsgn : s;

    double api = a * pi;
    double2 tt = tan_piby4(api, 0.0);
    long jr = s ^ as_long(e ? tt.hi : tt.lo);

    long si = xodd | 0x7ff0000000000000L;
    jr = r == 0.5 ? si : jr;

    ir = ix < 0x4330000000000000L ? jr : ir;

    return as_double(ir);
}

