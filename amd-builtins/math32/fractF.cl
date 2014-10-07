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
fract (float x, float *ip)
{
    float i = __amdil_round_neginf_f32(x);
    float r = x - i;
    r = __amdil_min_f32(r, 0x1.fffffep-1f);
    r = isinf(x) ? 0.0f : r;
    r = isnan(x) ? x : r;
    *ip = i;
    return  r;
}

#if __OPENCL_C_VERSION__ < 200

__attribute__((overloadable, always_inline)) float
fract(float x, __local float *ip)
{
    float i;
    float f = fract(x, &i);
    *ip = i;
    return f;
}

__attribute__((overloadable, always_inline)) float
fract(float x, __global float *ip)
{
    float i;
    float f = fract(x, &i);
    *ip = i;
    return f;
}

#endif
