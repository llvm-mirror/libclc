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

// ====================================================
// Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
//
// Developed at SunPro, a Sun Microsystems, Inc. business.
// Permission to use, copy, modify, and distribute this
// software is freely granted, provided that this notice
// is preserved.
// ====================================================

// lgamma_r(x, i)
// Reentrant version of the logarithm of the Gamma function
// with user provide pointer for the sign of Gamma(x).
//
// Method:
//   1. Argument Reduction for 0 < x <= 8
//      Since gamma(1+s)=s*gamma(s), for x in [0,8], we may
//      reduce x to a number in [1.5,2.5] by
//              lgamma(1+s) = log(s) + lgamma(s)
//      for example,
//              lgamma(7.3) = log(6.3) + lgamma(6.3)
//                          = log(6.3*5.3) + lgamma(5.3)
//                          = log(6.3*5.3*4.3*3.3*2.3) + lgamma(2.3)
//   2. Polynomial approximation of lgamma around its
//      minimun ymin=1.461632144968362245 to maintain monotonicity.
//      On [ymin-0.23, ymin+0.27] (i.e., [1.23164,1.73163]), use
//              Let z = x-ymin;
//              lgamma(x) = -1.214862905358496078218 + z^2*poly(z)
//      where
//              poly(z) is a 14 degree polynomial.
//   2. Rational approximation in the primary interval [2,3]
//      We use the following approximation:
//              s = x-2.0;
//              lgamma(x) = 0.5*s + s*P(s)/Q(s)
//      with accuracy
//              |P/Q - (lgamma(x)-0.5s)| < 2**-61.71
//      Our algorithms are based on the following observation
//
//                             zeta(2)-1    2    zeta(3)-1    3
// lgamma(2+s) = s*(1-Euler) + --------- * s  -  --------- * s  + ...
//                                 2                 3
//
//      where Euler = 0.5771... is the Euler constant, which is very
//      close to 0.5.
//
//   3. For x>=8, we have
//      lgamma(x)~(x-0.5)log(x)-x+0.5*log(2pi)+1/(12x)-1/(360x**3)+....
//      (better formula:
//         lgamma(x)~(x-0.5)*(log(x)-1)-.5*(log(2pi)-1) + ...)
//      Let z = 1/x, then we approximation
//              f(z) = lgamma(x) - (x-0.5)(log(x)-1)
//      by
//                                  3       5             11
//              w = w0 + w1*z + w2*z  + w3*z  + ... + w6*z
//      where
//              |w - f(z)| < 2**-58.74
//
//   4. For negative x, since (G is gamma function)
//              -x*G(-x)*G(x) = pi/sin(pi*x),
//      we have
//              G(x) = pi/(sin(pi*x)*(-x)*G(-x))
//      since G(-x) is positive, sign(G(x)) = sign(sin(pi*x)) for x<0
//      Hence, for x<0, signgam = sign(sin(pi*x)) and
//              lgamma(x) = log(|Gamma(x)|)
//                        = log(pi/(|x*sin(pi*x)|)) - lgamma(-x);
//      Note: one should avoid compute pi*(-x) directly in the
//            computation of sin(pi*(-x)).
//
//   5. Special Cases
//              lgamma(2+s) ~ s*(1-Euler) for tiny s
//              lgamma(1)=lgamma(2)=0
//              lgamma(x) ~ -log(x) for tiny x
//              lgamma(0) = lgamma(inf) = inf
//              lgamma(-integer) = +-inf
//

#define pi 3.14159265358979311600e+00	/* 0x400921FB, 0x54442D18 */

#define a0 7.72156649015328655494e-02	/* 0x3FB3C467, 0xE37DB0C8 */
#define a1 3.22467033424113591611e-01	/* 0x3FD4A34C, 0xC4A60FAD */
#define a2 6.73523010531292681824e-02	/* 0x3FB13E00, 0x1A5562A7 */
#define a3 2.05808084325167332806e-02	/* 0x3F951322, 0xAC92547B */
#define a4 7.38555086081402883957e-03	/* 0x3F7E404F, 0xB68FEFE8 */
#define a5 2.89051383673415629091e-03	/* 0x3F67ADD8, 0xCCB7926B */
#define a6 1.19270763183362067845e-03	/* 0x3F538A94, 0x116F3F5D */
#define a7 5.10069792153511336608e-04	/* 0x3F40B6C6, 0x89B99C00 */
#define a8 2.20862790713908385557e-04	/* 0x3F2CF2EC, 0xED10E54D */
#define a9 1.08011567247583939954e-04	/* 0x3F1C5088, 0x987DFB07 */
#define a10 2.52144565451257326939e-05	/* 0x3EFA7074, 0x428CFA52 */
#define a11 4.48640949618915160150e-05	/* 0x3F07858E, 0x90A45837 */

#define tc 1.46163214496836224576e+00	/* 0x3FF762D8, 0x6356BE3F */
#define tf -1.21486290535849611461e-01	/* 0xBFBF19B9, 0xBCC38A42 */
#define tt -3.63867699703950536541e-18	/* 0xBC50C7CA, 0xA48A971F */

#define t0 4.83836122723810047042e-01	/* 0x3FDEF72B, 0xC8EE38A2 */
#define t1 -1.47587722994593911752e-01	/* 0xBFC2E427, 0x8DC6C509 */
#define t2 6.46249402391333854778e-02	/* 0x3FB08B42, 0x94D5419B */
#define t3 -3.27885410759859649565e-02	/* 0xBFA0C9A8, 0xDF35B713 */
#define t4 1.79706750811820387126e-02	/* 0x3F9266E7, 0x970AF9EC */
#define t5 -1.03142241298341437450e-02	/* 0xBF851F9F, 0xBA91EC6A */
#define t6 6.10053870246291332635e-03	/* 0x3F78FCE0, 0xE370E344 */
#define t7 -3.68452016781138256760e-03	/* 0xBF6E2EFF, 0xB3E914D7 */
#define t8 2.25964780900612472250e-03	/* 0x3F6282D3, 0x2E15C915 */
#define t9 -1.40346469989232843813e-03	/* 0xBF56FE8E, 0xBF2D1AF1 */
#define t10 8.81081882437654011382e-04	/* 0x3F4CDF0C, 0xEF61A8E9 */
#define t11 -5.38595305356740546715e-04	/* 0xBF41A610, 0x9C73E0EC */
#define t12 3.15632070903625950361e-04	/* 0x3F34AF6D, 0x6C0EBBF7 */
#define t13 -3.12754168375120860518e-04	/* 0xBF347F24, 0xECC38C38 */
#define t14 3.35529192635519073543e-04	/* 0x3F35FD3E, 0xE8C2D3F4 */

#define u0 -7.72156649015328655494e-02	/* 0xBFB3C467, 0xE37DB0C8 */
#define u1 6.32827064025093366517e-01	/* 0x3FE4401E, 0x8B005DFF */
#define u2 1.45492250137234768737e+00	/* 0x3FF7475C, 0xD119BD6F */
#define u3 9.77717527963372745603e-01	/* 0x3FEF4976, 0x44EA8450 */
#define u4 2.28963728064692451092e-01	/* 0x3FCD4EAE, 0xF6010924 */
#define u5 1.33810918536787660377e-02	/* 0x3F8B678B, 0xBF2BAB09 */

#define v1 2.45597793713041134822e+00	/* 0x4003A5D7, 0xC2BD619C */
#define v2 2.12848976379893395361e+00	/* 0x40010725, 0xA42B18F5 */
#define v3 7.69285150456672783825e-01	/* 0x3FE89DFB, 0xE45050AF */
#define v4 1.04222645593369134254e-01	/* 0x3FBAAE55, 0xD6537C88 */
#define v5 3.21709242282423911810e-03	/* 0x3F6A5ABB, 0x57D0CF61 */

#define s0 -7.72156649015328655494e-02	/* 0xBFB3C467, 0xE37DB0C8 */
#define s1 2.14982415960608852501e-01	/* 0x3FCB848B, 0x36E20878 */
#define s2 3.25778796408930981787e-01	/* 0x3FD4D98F, 0x4F139F59 */
#define s3 1.46350472652464452805e-01	/* 0x3FC2BB9C, 0xBEE5F2F7 */
#define s4 2.66422703033638609560e-02	/* 0x3F9B481C, 0x7E939961 */
#define s5 1.84028451407337715652e-03	/* 0x3F5E26B6, 0x7368F239 */
#define s6 3.19475326584100867617e-05	/* 0x3F00BFEC, 0xDD17E945 */

#define r1 1.39200533467621045958e+00	/* 0x3FF645A7, 0x62C4AB74 */
#define r2 7.21935547567138069525e-01	/* 0x3FE71A18, 0x93D3DCDC */
#define r3 1.71933865632803078993e-01	/* 0x3FC601ED, 0xCCFBDF27 */
#define r4 1.86459191715652901344e-02	/* 0x3F9317EA, 0x742ED475 */
#define r5 7.77942496381893596434e-04	/* 0x3F497DDA, 0xCA41A95B */
#define r6 7.32668430744625636189e-06	/* 0x3EDEBAF7, 0xA5B38140 */

#define w0 4.18938533204672725052e-01	/* 0x3FDACFE3, 0x90C97D69 */
#define w1 8.33333333333329678849e-02	/* 0x3FB55555, 0x5555553B */
#define w2 -2.77777777728775536470e-03	/* 0xBF66C16C, 0x16B02E5C */
#define w3 7.93650558643019558500e-04	/* 0x3F4A019F, 0x98CF38B6 */
#define w4 -5.95187557450339963135e-04	/* 0xBF4380CB, 0x8C0FE741 */
#define w5 8.36339918996282139126e-04	/* 0x3F4B67BA, 0x4CDAD5D1 */
#define w6 -1.63092934096575273989e-03	/* 0xBF5AB89D, 0x0B9E43E4 */

__attribute__ ((overloadable, always_inline)) double
lgamma_r(double x, int *ip)
{
    ulong ux = as_ulong(x);
    ulong ax = ux & EXSIGNBIT_DP64;
    double absx = as_double(ax);

    if (ax >= 0x7ff0000000000000UL) {
        // +-Inf, NaN
	*ip = 1;
	return absx;
    }

    if (absx < 0x1.0p-70) {
	*ip = ax == ux ? 1 : -1;
	return -log(absx);
    }

    // Handle rest of range
    double r;

    if (absx < 2.0) {
	int i = 0;
	double y = 2.0 - absx;

	int c = absx < 0x1.bb4c3p+0;
	double t = absx - tc;
	i = c ? 1 : i;
	y = c ? t : y;

	c = absx < 0x1.3b4c4p+0;
	t = absx - 1.0;
	i = c ? 2 : i;
	y = c ? t : y;

	c = absx <= 0x1.cccccp-1;
	t = -log(absx);
	r = c ? t : 0.0;
	t = 1.0 - absx;
	i = c ? 0 : i;
	y = c ? t : y;

	c = absx < 0x1.76944p-1;
	t = absx - (tc - 1.0);
	i = c ? 1 : i;
	y = c ? t : y;

	c = absx < 0x1.da661p-3;
	i = c ? 2 : i;
	y = c ? absx : y;

	double p, q;

	switch (i) {
	case 0:
	    p = fma(y, fma(y, fma(y, fma(y, a11, a10), a9), a8), a7);
	    p = fma(y, fma(y, fma(y, fma(y, p, a6), a5), a4), a3);
	    p = fma(y, fma(y, fma(y, p, a2), a1), a0);
	    r = fma(y, p - 0.5, r);
	    break;
	case 1:
	    p = fma(y, fma(y, fma(y, fma(y, t14, t13), t12), t11), t10);
	    p = fma(y, fma(y, fma(y, fma(y, fma(y, p, t9), t8), t7), t6), t5);
	    p = fma(y, fma(y, fma(y, fma(y, fma(y, p, t4), t3), t2), t1), t0);
	    p = fma(y*y, p, -tt);
	    r += (tf + p);
	    break;
	case 2:
	    p = y*fma(y, fma(y, fma(y, fma(y, fma(y, u5, u4), u3), u2), u1), u0);
	    q = fma(y, fma(y, fma(y, fma(y, fma(y, v5, v4), v3), v2), v1), 1.0);
	    r += fma(-0.5, y, p/q);
	}
    } else if (absx < 8.0) {
	int i = absx;
	double y = absx - (double)i;
	double p = y*fma(y, fma(y, fma(y, fma(y, fma(y, fma(y, s6, s5), s4), s3), s2), s1), s0);
	double q = fma(y, fma(y, fma(y, fma(y, fma(y, fma(y, r6, r5), r4), r3), r2), r1), 1.0);
	r = fma(0.5, y, p/q);
	double z = 1.0;
	// lgamma(1+s) = log(s) + lgamma(s)
	double y6 = y + 6.0;
	double y5 = y + 5.0;
	double y4 = y + 4.0;
	double y3 = y + 3.0;
	double y2 = y + 2.0;
	z *= i > 6 ? y6 : 1.0;
	z *= i > 5 ? y5 : 1.0;
	z *= i > 4 ? y4 : 1.0;
	z *= i > 3 ? y3 : 1.0;
	z *= i > 2 ? y2 : 1.0;
        r += log(z);
    } else {
	double z = 1.0 / absx;
	double z2 = z * z;
	double w = fma(z, fma(z2, fma(z2, fma(z2, fma(z2, fma(z2, w6, w5), w4), w3), w2), w1), w0);
	r = (absx - 0.5) * (log(absx) - 1.0) + w;
    }

    if (x < 0.0) {
	double t = sinpi(x);
	r = log(pi / fabs(t * x)) - r;
	r = t == 0.0 ? as_double(PINFBITPATT_DP64) : r;
	*ip = t < 0.0 ? -1 : 1;
    } else
	*ip = 1;

    return r;
}

#if __OPENCL_C_VERSION__ < 200
__attribute__ ((overloadable, always_inline)) double
lgamma_r(double x, __local int *ip)
{
    int i;
    double ret = lgamma_r(x, &i);
    *ip = i;
    return ret;
}

__attribute__ ((overloadable, always_inline)) double
lgamma_r(double x, __global int *ip)
{
    int i;
    double ret = lgamma_r(x, &i);
    *ip = i;
    return ret;
}
#endif

__attribute__ ((overloadable, always_inline)) double
lgamma(double x)
{
    int i;
    return lgamma_r(x, &i);
}

