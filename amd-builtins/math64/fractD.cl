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

__attribute__((overloadable, always_inline)) double
fract(double x, double *ip)
{
    long j = as_long(x);
    long z = j & 0x8000000000000000L;
    long a = j ^ z;
    long n = a == 0x7ff0000000000000L ? z : j;
    long s = a != 0L & z != 0L ? 0xbff0000000000000L : z;
    int e = ((int)(j >> 52) & 0x7ff) - 1023;
    long m = 0x000fffffffffffffL >> e;
    long k = 0x0010000000000000L >> e;
    k = (j & m) != 0L & z != 0L ? k : 0L;
    k += j;
    k &= ~m;
    k = e < 0 ? s : k;
    k = e > 51 ? j : k;
    double i = as_double(k);
    long d = as_long(x - i);
    d -= d == 0x3ff0000000000000L;
    d = a ? d : z;
    d = e == 1024 ? n : d;
    *ip = i;
    return as_double(d);
}

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline)) double
fract(double x, __local double *ip)
{
    double i;
    double f = fract(x, &i);
    *ip = i;
    return f;
}

__attribute__((overloadable, always_inline)) double
fract(double x, __global double *ip)
{
    double i;
    double f = fract(x, &i);
    *ip = i;
    return f;
}
#endif
