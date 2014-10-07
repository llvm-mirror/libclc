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

__attribute__((overloadable, always_inline)) float
modf(float x, float *iptr)
{
    int ux = as_int(x);
    int e = ((ux >> 23) & 0xff) - 127;
    int s = ux & 0x80000000;
    int msk = 0xffffffff << (23 - e);
    int i = msk & ux;
    int r = as_uint(x - as_float(i)) | s;

    r = e < 0 ? ux : r;
    i = e < 0 ? s : i;

    r = e >= 23 ? s : r;
    i = e >= 23 ? ux : i;

    r = (ux & 0x7fffffff) > 0x7f800000 ? ux : r;

    *iptr = as_float(i);
    return as_float(r);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline)) float
modf(float x, __global float *iptr)
{
    float i;
    float f = modf(x, &i);
    *iptr = i;
    return f;
}

__attribute__((overloadable, always_inline)) float
modf(float x, __local float *iptr)
{
    float i;
    float f = modf(x, &i);
    *iptr = i;
    return f;
}
#endif

