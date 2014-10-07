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
half_divide(float x, float y)
{
    int c = fabs(y) > 0x1.0p+96f;
    float s = c ? 0x1.0p-32f : 1.0f;
    y *= s;
    return s * native_divide(x, y);
}

//__attribute__((overloadable, always_inline)) float2
//half_divide(float2 x, float2 y)
//{
//    int2 c = fabs(y) > 0x1.0p+96f;
//    float2 s = c ? 0x1.0p-32f : 1.0f;
//    y *= s;
//    return s * native_divide(x, y);
//}
//
//__attribute__((overloadable, always_inline)) float4
//half_divide(float4 x, float4 y)
//{
//    int4 c = fabs(y) > 0x1.0p+96f;
//    float4 s = c ? 0x1.0p-32f : 1.0f;
//    y *= s;
//    return s * native_divide(x, y);
//}

