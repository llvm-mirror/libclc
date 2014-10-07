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

/*
 * ====================================================
 * Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
 *
 * Developed at SunPro, a Sun Microsystems, Inc. business.
 * Permission to use, copy, modify, and distribute this
 * software is freely granted, provided that this notice
 * is preserved.
 * ====================================================
 */

/* double erf(double x)
 * double erfc(double x)
 *                             x
 *                      2      |\
 *     erf(x)  =  ---------  | exp(-t*t)dt
 *                    sqrt(pi) \|
 *                             0
 *
 *     erfc(x) =  1-erf(x)
 *  Note that
 *                erf(-x) = -erf(x)
 *                erfc(-x) = 2 - erfc(x)
 *
 * Method:
 *        1. For |x| in [0, 0.84375]
 *            erf(x)  = x + x*R(x^2)
 *          erfc(x) = 1 - erf(x)           if x in [-.84375,0.25]
 *                  = 0.5 + ((0.5-x)-x*R)  if x in [0.25,0.84375]
 *           where R = P/Q where P is an odd poly of degree 8 and
 *           Q is an odd poly of degree 10.
 *                                                 -57.90
 *                        | R - (erf(x)-x)/x | <= 2
 *
 *
 *           Remark. The formula is derived by noting
 *          erf(x) = (2/sqrt(pi))*(x - x^3/3 + x^5/10 - x^7/42 + ....)
 *           and that
 *          2/sqrt(pi) = 1.128379167095512573896158903121545171688
 *           is close to one. The interval is chosen because the fix
 *           point of erf(x) is near 0.6174 (i.e., erf(x)=x when x is
 *           near 0.6174), and by some experiment, 0.84375 is chosen to
 *            guarantee the error is less than one ulp for erf.
 *
 *      2. For |x| in [0.84375,1.25], let s = |x| - 1, and
 *         c = 0.84506291151 rounded to single (24 bits)
 *                 erf(x)  = sign(x) * (c  + P1(s)/Q1(s))
 *                 erfc(x) = (1-c)  - P1(s)/Q1(s) if x > 0
 *                          1+(c+P1(s)/Q1(s))    if x < 0
 *                 |P1/Q1 - (erf(|x|)-c)| <= 2**-59.06
 *           Remark: here we use the taylor series expansion at x=1.
 *                erf(1+s) = erf(1) + s*Poly(s)
 *                         = 0.845.. + P1(s)/Q1(s)
 *           That is, we use rational approximation to approximate
 *                        erf(1+s) - (c = (single)0.84506291151)
 *           Note that |P1/Q1|< 0.078 for x in [0.84375,1.25]
 *           where
 *                P1(s) = degree 6 poly in s
 *                Q1(s) = degree 6 poly in s
 *
 *      3. For x in [1.25,1/0.35(~2.857143)],
 *                 erfc(x) = (1/x)*exp(-x*x-0.5625+R1/S1)
 *                 erf(x)  = 1 - erfc(x)
 *           where
 *                R1(z) = degree 7 poly in z, (z=1/x^2)
 *                S1(z) = degree 8 poly in z
 *
 *      4. For x in [1/0.35,28]
 *                 erfc(x) = (1/x)*exp(-x*x-0.5625+R2/S2) if x > 0
 *                        = 2.0 - (1/x)*exp(-x*x-0.5625+R2/S2) if -6<x<0
 *                        = 2.0 - tiny                (if x <= -6)
 *                 erf(x)  = sign(x)*(1.0 - erfc(x)) if x < 6, else
 *                 erf(x)  = sign(x)*(1.0 - tiny)
 *           where
 *                R2(z) = degree 6 poly in z, (z=1/x^2)
 *                S2(z) = degree 7 poly in z
 *
 *      Note1:
 *           To compute exp(-x*x-0.5625+R/S), let s be a single
 *           precision number and s := x; then
 *                -x*x = -s*s + (s-x)*(s+x)
 *                exp(-x*x-0.5626+R/S) =
 *                        exp(-s*s-0.5625)*exp((s-x)*(s+x)+R/S);
 *      Note2:
 *           Here 4 and 5 make use of the asymptotic series
 *                          exp(-x*x)
 *                erfc(x) ~ ---------- * ( 1 + Poly(1/x^2) )
 *                          x*sqrt(pi)
 *           We use rational approximation to approximate
 *              g(s)=f(1/x^2) = log(erfc(x)*x) - x*x + 0.5625
 *           Here is the error bound for R1/S1 and R2/S2
 *              |R1/S1 - f(x)|  < 2**(-62.57)
 *              |R2/S2 - f(x)|  < 2**(-61.52)
 *
 *      5. For inf > x >= 28
 *                 erf(x)  = sign(x) *(1 - tiny)  (raise inexact)
 *                 erfc(x) = tiny*tiny (raise underflow) if x > 0
 *                        = 2 - tiny if x<0
 *
 *      7. Special case:
 *                 erf(0)  = 0, erf(inf)  = 1, erf(-inf) = -1,
 *                 erfc(0) = 1, erfc(inf) = 0, erfc(-inf) = 2,
 *                   erfc/erf(NaN) is NaN
 */

#define AU0 -9.86494292470009928597e-03
#define AU1 -7.99283237680523006574e-01
#define AU2 -1.77579549177547519889e+01
#define AU3 -1.60636384855821916062e+02
#define AU4 -6.37566443368389627722e+02
#define AU5 -1.02509513161107724954e+03
#define AU6 -4.83519191608651397019e+02

#define AV0  3.03380607434824582924e+01
#define AV1  3.25792512996573918826e+02
#define AV2  1.53672958608443695994e+03
#define AV3  3.19985821950859553908e+03
#define AV4  2.55305040643316442583e+03
#define AV5  4.74528541206955367215e+02
#define AV6 -2.24409524465858183362e+01

#define BU0 -9.86494403484714822705e-03
#define BU1 -6.93858572707181764372e-01
#define BU2 -1.05586262253232909814e+01
#define BU3 -6.23753324503260060396e+01
#define BU4 -1.62396669462573470355e+02
#define BU5 -1.84605092906711035994e+02
#define BU6 -8.12874355063065934246e+01
#define BU7 -9.81432934416914548592e+00

#define BV0  1.96512716674392571292e+01
#define BV1  1.37657754143519042600e+02
#define BV2  4.34565877475229228821e+02
#define BV3  6.45387271733267880336e+02
#define BV4  4.29008140027567833386e+02
#define BV5  1.08635005541779435134e+02
#define BV6  6.57024977031928170135e+00
#define BV7 -6.04244152148580987438e-02

#define CU0 -2.36211856075265944077e-03
#define CU1  4.14856118683748331666e-01
#define CU2 -3.72207876035701323847e-01
#define CU3  3.18346619901161753674e-01
#define CU4 -1.10894694282396677476e-01
#define CU5  3.54783043256182359371e-02
#define CU6 -2.16637559486879084300e-03

#define CV0 1.06420880400844228286e-01
#define CV1 5.40397917702171048937e-01
#define CV2 7.18286544141962662868e-02
#define CV3 1.26171219808761642112e-01
#define CV4 1.36370839120290507362e-02
#define CV5 1.19844998467991074170e-02

#define DU0  1.28379167095512558561e-01
#define DU1 -3.25042107247001499370e-01
#define DU2 -2.84817495755985104766e-02
#define DU3 -5.77027029648944159157e-03
#define DU4 -2.37630166566501626084e-05

#define DV0  3.97917223959155352819e-01
#define DV1  6.50222499887672944485e-02
#define DV2  5.08130628187576562776e-03
#define DV3  1.32494738004321644526e-04
#define DV4 -3.96022827877536812320e-06

__attribute__((overloadable)) double
erfc(double x)
{
    long lx = as_long(x);
    long ax = lx & 0x7fffffffffffffffL;
    double absx = as_double(ax);
    int xneg = lx != ax;

    // Poly arg
    double x2 = x * x;
    double xm1 = absx - 1.0;
    double t = 1.0 / x2;
    t = absx < 1.25 ? xm1 : t;
    t = absx < 0.84375 ? x2 : t;


    // Evaluate rational poly
    // XXX Need to evaluate if we can grab the 14 coefficients from a
    // table faster than evaluating 3 pairs of polys
    double tu, tv, u, v;

    // |x| < 28
    u = fma(t, fma(t, fma(t, fma(t, fma(t, fma(t, AU6, AU5), AU4), AU3), AU2), AU1), AU0);
    v = fma(t, fma(t, fma(t, fma(t, fma(t, fma(t, AV6, AV5), AV4), AV3), AV2), AV1), AV0);

    tu = fma(t, fma(t, fma(t, fma(t, fma(t, fma(t, fma(t, BU7, BU6), BU5), BU4), BU3), BU2), BU1), BU0);
    tv = fma(t, fma(t, fma(t, fma(t, fma(t, fma(t, fma(t, BV7, BV6), BV5), BV4), BV3), BV2), BV1), BV0);
    u = absx < 0x1.6db6dp+1 ? tu : u;
    v = absx < 0x1.6db6dp+1 ? tv : v;

    tu = fma(t, fma(t, fma(t, fma(t, fma(t, fma(t, CU6, CU5), CU4), CU3), CU2), CU1), CU0);
    tv = fma(t, fma(t, fma(t, fma(t, fma(t, CV5, CV4), CV3), CV2), CV1), CV0);
    u = absx < 1.25 ? tu : u;
    v = absx < 1.25 ? tv : v;

    tu = fma(t, fma(t, fma(t, fma(t, DU4, DU3), DU2), DU1), DU0);
    tv = fma(t, fma(t, fma(t, fma(t, DV4, DV3), DV2), DV1), DV0);
    u = absx < 0.84375 ? tu : u;
    v = absx < 0.84375 ? tv : v;

    v = fma(t, v, 1.0);
    double q = u / v;


    // Evaluate return value

    // |x| < 28
    double z = as_double(ax & 0xffffffff00000000UL);
    double ret = exp(-z * z - 0.5625) * exp((z - absx) * (z + absx) + q) / absx;
    t = 2.0 - ret;
    ret = xneg ? t : ret;

    const double erx = 8.45062911510467529297e-01;
    z = erx + q + 1.0;
    t = 1.0 - erx - q;
    t = xneg ? z : t;
    ret = absx < 1.25 ? t : ret;

    // z = 1.0 - fma(x, q, x);
    // t = 0.5 - fma(x, q, x - 0.5);
    // t = xneg == 1 | absx < 0.25 ? z : t;
    t = fma(-x, q, 1.0 - x);
    ret = absx < 0.84375 ? t : ret;

    ret = x >= 28.0 ? 0.0 : ret;
    ret = x <= -6.0 ? 2.0 : ret;
    ret = ax > 0x7ff0000000000000UL ? x : ret;

    return ret;
}

