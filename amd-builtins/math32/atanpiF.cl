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
atanpi(float x)
{
    const float pi = 3.1415926535897932f;

    uint ux = as_uint(x);
    uint aux = ux & EXSIGNBIT_SP32;
    uint sx = ux ^ aux;

    float xbypi = MATH_DIVIDE(x, pi);
    float shalf = as_float(sx | as_uint(0.5f));

    float v = as_float(aux);

    // Return for NaN
    float ret = x;

    // 2^26 <= |x| <= Inf => atan(x) is close to piby2
    ret = aux <= PINFBITPATT_SP32  ? shalf : ret;

    // Reduce arguments 2^-19 <= |x| < 2^26

    // 39/16 <= x < 2^26
    x = -MATH_RECIP(v);
    float c = 1.57079632679489655800f; // atan(infinity)

    // 19/16 <= x < 39/16
    int l = aux < 0x401c0000;
    float xx = MATH_DIVIDE(v - 1.5f, mad(v, 1.5f, 1.0f));
    x = l ? xx : x;
    c = l ? 9.82793723247329054082e-01f : c; // atan(1.5)

    // 11/16 <= x < 19/16
    l = aux < 0x3f980000U;
    xx =  MATH_DIVIDE(v - 1.0f, 1.0f + v);
    x = l ? xx : x;
    c = l ? 7.85398163397448278999e-01f : c; // atan(1)

    // 7/16 <= x < 11/16
    l = aux < 0x3f300000;
    xx = MATH_DIVIDE(mad(v, 2.0f, -1.0f), 2.0f + v);
    x = l ? xx : x;
    c = l ? 4.63647609000806093515e-01f : c; // atan(0.5)

    // 2^-19 <= x < 7/16
    l = aux < 0x3ee00000;
    x = l ? v : x;
    c = l ? 0.0f : c;

    // Core approximation: Remez(2,2) on [-7/16,7/16]

    float s = x * x;
    float a = mad(s,
                  mad(s, 0.470677934286149214138357545549e-2f, 0.192324546402108583211697690500f),
                  0.296528598819239217902158651186f);

    float b = mad(s,
                  mad(s, 0.299309699959659728404442796915f, 0.111072499995399550138837673349e1f),
                  0.889585796862432286486651434570f);

    float q = x * s * MATH_DIVIDE(a, b);

    float z = c - (q - x);
    z = MATH_DIVIDE(z, pi);
    float zs = as_float(sx | as_uint(z));

    ret  = aux < 0x4c800000 ?  zs : ret;

    // |x| < 2^-19
    ret = aux < 0x36000000 ? xbypi : ret;
    return ret;
}

