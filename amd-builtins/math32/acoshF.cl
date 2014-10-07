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
acosh(float x)
{
    uint ux = as_uint(x);

    // Arguments greater than 1/sqrt(epsilon) in magnitude are
    // approximated by acosh(x) = ln(2) + ln(x)
    // For 2.0 <= x <= 1/sqrt(epsilon) the approximation is
    // acosh(x) = ln(x + sqrt(x*x-1)) */
    int high = ux > 0x46000000U;
    int med = ux > 0x40000000U;

    float w = x - 1.0f;
    float s = w*w + 2.0f*w;
    float t = x*x - 1.0f;
    float r = MATH_SQRT(med ? t : s) + (med ? x : w);
    float v = (high ? x : r) - (med ? 1.0f : 0.0f);
    float z = log1p(v) + (high ? 0x1.62e430p-1f : 0.0f);

    z = ux >= PINFBITPATT_SP32 ? x : z;
    z = x < 1.0f ? as_float(QNANBITPATT_SP32) : z;

    return z;
}

