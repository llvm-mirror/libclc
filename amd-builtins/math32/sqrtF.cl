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

__attribute__((overloadable, always_inline, weak)) float
sqrt(float x)
{
#if !defined(SUBNORMALS_SUPPORTED)
    int i = as_int(x);
    int ai = i & 0x7fffffff;
    int d = ai > 0 & ai < 0x00800000;
    // scale subnormal by 2^26 without multiplying to avoid input flush
    float s = as_float(i | 0x0d800000) - 0x1.0p-100F;
    x = d ? s : x;
    x = MATH_SQRT(x);
    x *= d ? 0x1.0p-13F : 1.0F;
    return x;
#else //SUBNORMALS_SUPPORTED
    return native_sqrt(x);
#endif
}
