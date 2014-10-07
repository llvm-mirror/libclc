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
atan(double x)
{
    const double piby2 = 1.5707963267948966e+00; // 0x3ff921fb54442d18

    double v = fabs(x);

    // 2^56 > v > 39/16
    double a = -1.0;
    double b = v;
    // (chi + clo) = arctan(infinity)
    double chi = 1.57079632679489655800e+00;
    double clo = 6.12323399573676480327e-17;

    double ta = v - 1.5;
    double tb = 1.0 + 1.5 * v;
    int l = v <= 0x1.38p+1; // 39/16 > v > 19/16
    a = l ? ta : a;
    b = l ? tb : b;
    // (chi + clo) = arctan(1.5)
    chi = l ? 9.82793723247329054082e-01 : chi;
    clo = l ? 1.39033110312309953701e-17 : clo;

    ta = v - 1.0;
    tb = 1.0 + v;
    l = v <= 0x1.3p+0; // 19/16 > v > 11/16
    a = l ? ta : a;
    b = l ? tb : b;
    // (chi + clo) = arctan(1.)
    chi = l ? 7.85398163397448278999e-01 : chi;
    clo = l ? 3.06161699786838240164e-17 : clo;

    ta = 2.0 * v - 1.0;
    tb = 2.0 + v;
    l = v <= 0x1.6p-1; // 11/16 > v > 7/16
    a = l ? ta : a;
    b = l ? tb : b;
    // (chi + clo) = arctan(0.5)
    chi = l ? 4.63647609000806093515e-01 : chi;
    clo = l ? 2.26987774529616809294e-17 : clo;

    l = v <= 0x1.cp-2; // v < 7/16
    a = l ? v : a;
    b = l ? 1.0 : b;;
    chi = l ? 0.0 : chi;
    clo = l ? 0.0 : clo;

    // Core approximation: Remez(4,4) on [-7/16,7/16]
    double r = a / b;
    double s = r * r;
    double qn = fma(s,
                    fma(s,
                        fma(s,
                            fma(s, 0.142316903342317766e-3,
                                   0.304455919504853031e-1),
                            0.220638780716667420e0),
                        0.447677206805497472e0),
                    0.268297920532545909e0);

    double qd = fma(s,
	            fma(s,
			fma(s,
			    fma(s, 0.389525873944742195e-1,
				   0.424602594203847109e0),
                            0.141254259931958921e1),
                        0.182596787737507063e1),
                    0.804893761597637733e0);

    double q = r * s * qn / qd;
    r = chi - ((q - clo) - r);

    double z = isnan(x) ? x : piby2;
    z = v <= 0x1.0p+56 ? r : z;
    z = v < 0x1.0p-26 ? v : z;
    return x == v ? z : -z;
}

