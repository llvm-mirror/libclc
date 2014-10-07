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
acos(float x)
{
    // Computes arccos(x).
    // The argument is first reduced by noting that arccos(x)
    // is invalid for abs(x) > 1. For denormal and small
    // arguments arccos(x) = pi/2 to machine accuracy.
    // Remaining argument ranges are handled as follows.
    // For abs(x) <= 0.5 use
    // arccos(x) = pi/2 - arcsin(x)
    // = pi/2 - (x + x^3*R(x^2))
    // where R(x^2) is a rational minimax approximation to
    // (arcsin(x) - x)/x^3.
    // For abs(x) > 0.5 exploit the identity:
    // arccos(x) = pi - 2*arcsin(sqrt(1-x)/2)
    // together with the above rational approximation, and
    // reconstruct the terms carefully.


    // Some constants and split constants.
    const float piby2 = 1.5707963705e+00F;
    const float pi = 3.1415926535897933e+00F;
    const float piby2_head = 1.5707963267948965580e+00F;
    const float piby2_tail = 6.12323399573676603587e-17F;

    uint ux = as_uint(x);
    uint aux = ux & ~SIGNBIT_SP32;
    int xneg = ux != aux;
    int xexp = (int)(aux >> EXPSHIFTBITS_SP32) - EXPBIAS_SP32;
    float y = as_float(aux);

    // transform if |x| >= 0.5
    int transform = xexp >= -1;

    float y2 = y * y;
    float yt = 0.5f * (1.0f - y);
    float r = transform ? yt : y2;

    // Use a rational approximation for [0.0, 0.5]
    float a = mad(r,
                  mad(r,
                      mad(r, -0.00396137437848476485201154797087F, -0.0133819288943925804214011424456F),
                      -0.0565298683201845211985026327361F),
                  0.184161606965100694821398249421F);

    float b = mad(r, -0.836411276854206731913362287293F, 1.10496961524520294485512696706F);
    float u = r * MATH_DIVIDE(a, b);

    float s = MATH_SQRT(r);
    y = s;
    float s1 = as_float(as_uint(s) & 0xffff0000);
    float c = MATH_DIVIDE(mad(s1, -s1, r), s + s1);
    float rettn = mad(s + mad(y, u, -piby2_tail), -2.0f, pi);
    float rettp = 2.0F * (s1 + mad(y, u, c));
    float rett = xneg ? rettn : rettp;
    float ret = piby2_head - (x - mad(x, -u, piby2_tail));

    ret = transform ? rett : ret;
    ret = aux > 0x3f800000U ? as_float(QNANBITPATT_SP32) : ret;
    ret = ux == 0x3f800000U ? 0.0f : ret;
    ret = ux == 0xbf800000U ? pi : ret;
    ret = xexp < -26 ? piby2 : ret;
    return ret;
}

