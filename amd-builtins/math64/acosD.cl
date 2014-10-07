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

__attribute__((overloadable)) double
acos(double x)
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

    const double pi = 3.1415926535897933e+00;             /* 0x400921fb54442d18 */
    const double piby2 = 1.5707963267948965580e+00;       /* 0x3ff921fb54442d18 */
    const double piby2_head = 1.5707963267948965580e+00;  /* 0x3ff921fb54442d18 */
    const double piby2_tail = 6.12323399573676603587e-17; /* 0x3c91a62633145c07 */

    double y = fabs(x);
    int xneg = as_int2(x).hi < 0;
    int xexp = (as_int2(y).hi >> 20) - EXPBIAS_DP64;

    // abs(x) >= 0.5
    int transform = xexp >= -1;

    double rt = 0.5 * (1.0 - y);
    double y2 = y * y;
    double r = transform ? rt : y2;

    // Use a rational approximation for [0.0, 0.5]
    double un = fma(r,
                    fma(r,
                        fma(r,
                            fma(r,
                                fma(r, 0.0000482901920344786991880522822991,
                                       0.00109242697235074662306043804220),
                                -0.0549989809235685841612020091328),
                            0.275558175256937652532686256258),
                        -0.445017216867635649900123110649),
                    0.227485835556935010735943483075);

    double ud = fma(r,
                    fma(r,
                        fma(r,
                            fma(r, 0.105869422087204370341222318533,
                                   -0.943639137032492685763471240072),
                            2.76568859157270989520376345954),
                        -3.28431505720958658909889444194),
                    1.36491501334161032038194214209);

    double u = r * MATH_DIVIDE(un, ud);

    // Reconstruct acos carefully in transformed region
    double s = sqrt(r);
    double ztn =  fma(-2.0, (s + fma(s, u, -piby2_tail)), pi);

    double s1 = as_double(as_ulong(s) & 0xffffffff00000000UL);
    double c = MATH_DIVIDE(fma(-s1, s1, r), s + s1);
    double ztp = 2.0 * (s1 + fma(s, u, c));
    double zt =  xneg ? ztn : ztp;
    double z = piby2_head - (x - fma(-x, u, piby2_tail));

    z =  transform ? zt : z;

    z = xexp < -56 ? piby2 : z;
/*    z = xexp >= 0 ? as_double(QNANBITPATT_DP64) : z; This check  for nan is not working */
	z = isnan(x) ? as_double((as_ulong(x) | QNANBITPATT_DP64)) : z;
    z = x == 1.0 ? 0.0 : z;
    z = x == -1.0 ? pi : z;

    return z;
}

