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

__attribute__((overloadable)) float
cospi(float x)
{
    const float pi = 3.1415926535897932F;

    int ix = as_int(x) & 0x7fffffff; 
    float ax = as_float(ix);
    int iax = (int)ax;
    float r = ax - iax;
    int xodd = iax & 0x1 ? 0x80000000 : 0;

    // Initialize with return for +-Inf and NaN
    int ir = 0x7fc00000;

    // 2^24 <= |x| < Inf, the result is always even integer
    ir = ix < 0x7f800000 ? 0x3f800000 : ir;

    // 2^23 <= |x| < 2^24, the result is always integer
    ir = ix < 0x4b800000 ? xodd | 0x3f800000 : ir;

    // 0x1.0p-7 <= |x| < 2^23, result depends on which 0.25 interval

    // r < 1.0
    float a = 1.0f - r;
    int e = 1;
    int s = xodd ^ 0x80000000;

    // r <= 0.75
    int c = r <= 0.75f;
    a = c ? r - 0.5f : a;
    e = c ? 0 : e;

    // r < 0.5
    c = r < 0.5f;
    a = c ? 0.5f - r : a;
    s = c ? xodd : s;

    // r <= 0.25
    c = r <= 0.25f;
    a = c ? r : a;
    e = c ? 1 : e;

    float2 t = sincosf_piby4(a * pi);
    int jr = s ^ as_int(e ? t.hi : t.lo);

    ir = ix < 0x4b000000 ? jr : ir;

    return as_float(ir);
}

