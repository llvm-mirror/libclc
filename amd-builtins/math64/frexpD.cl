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

__attribute__((overloadable, always_inline, weak)) double
frexp(double x, int *ep)
{
    long i = as_long(x);
    long ai = i & 0x7fffffffffffffffL;
    int d = ai > 0 & ai < 0x0010000000000000L;
    // scale subnormal by 2^54 without multiplying
    double s = as_double(ai | 0x0370000000000000L) - 0x1.0p-968;
    ai = d ? as_long(s) : ai;
    int e = (int)(ai >> 52) - 1022 - (d ? 54 : 0);
    int t = ai == 0 | e == 1025;
    i = (i & 0x8000000000000000L) | 0x3fe0000000000000L | (ai & 0x000fffffffffffffL);
    *ep = t ? 0 : e;
    return t ? x : as_double(i);
}

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double
frexp(double x, __local int *ep)
{
    int e;
    double f = frexp(x, &e);
    *ep = e;
    return f;
}

__attribute__((overloadable, always_inline, weak)) double
frexp(double x, __global int *ep)
{
    int e;
    double f = frexp(x, &e);
    *ep = e;
    return f;
}
#endif
