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

__attribute__((overloadable)) float
atanh(float x)
{
    uint ux = as_uint(x);
    uint ax = ux & EXSIGNBIT_SP32;
    uint xs = ux ^ ax;

    // |x| > 1 or NaN
    float z = as_float(QNANBITPATT_SP32);

    // |x| == 1
    float t = as_float(xs | PINFBITPATT_SP32);
    z = ax == 0x3f800000U ? t : z;

    // 1/2 <= |x| < 1
    t = as_float(ax);
    t = MATH_DIVIDE(2.0f*t, 1.0f - t);
    t = 0.5f * log1p(t);
    t = as_float(xs | as_uint(t));
    z = ax < 0x3f800000U ? t : z;

    // |x| < 1/2
    t = x * x;
    float a = mad(mad(0.92834212715e-2f, t, -0.28120347286e0f), t, 0.39453629046e0f);
    float b = mad(mad(0.45281890445e0f, t, -0.15537744551e1f), t, 0.11836088638e1f);
    float p = MATH_DIVIDE(a, b);
    t = mad(x*t, p, x);
    z = ax < 0x3f000000 ? t : z;

    // |x| < 2^-13
    z = ax < 0x39000000U ? x : z;

    return z;
}

