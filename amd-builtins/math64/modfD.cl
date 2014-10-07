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
modf(double x, double *iptr)
{
    long ux = as_long(x);
    int e = ((int)(ux >> 52) & 0x7ff) - 1023;
    long s = ux & 0x8000000000000000L;
    long msk = 0xffffffffffffffffL << (52 - e);
    long i = msk & ux;
    long r = as_long(x - as_double(i));

    r = e < 0 ? ux : r;
    i = e < 0 ? s : i;

    r = e >= 52 ? s : r;
    i = e >= 52 ? ux : i;

    r = (ux & 0x7fffffffffffffffL) > 0x7ff0000000000000L ? ux : r;

    *iptr = as_double(i);
    return as_double(r);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline)) double
modf(double x, __global double *iptr)
{
    double i;
    double f = modf(x, &i);
    *iptr = i;
    return f;
}

__attribute__((overloadable, always_inline)) double
modf(double x, __local double *iptr)
{
    double i;
    double f = modf(x, &i);
    *iptr = i;
    return f;
}
#endif

