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
cosh(double x)
{
    USE_TABLE(double2, sinh_tbl, SINH_TBL);
    USE_TABLE(double2, cosh_tbl, COSH_TBL);

    // After dealing with special cases the computation is split into
    // regions as follows:
    //
    // abs(x) >= max_cosh_arg:
    // cosh(x) = sign(x)*Inf
    //
    // abs(x) >= small_threshold:
    // cosh(x) = sign(x)*exp(abs(x))/2 computed using the
    // splitexp and scaleDouble functions as for exp_amd().
    //
    // abs(x) < small_threshold:
    // compute p = exp(y) - 1 and then z = 0.5*(p+(p/(p+1.0)))
    // cosh(x) is then sign(x)*z.                             */

    // This is ln(2^1025)
    const double max_cosh_arg = 7.10475860073943977113e+02;      /* 0x408633ce8fb9f87e */

    // This is where exp(-x) is insignificant compared to exp(x) = ln(2^27)
    const double small_threshold = 0x1.2b708872320e2p+4;

    double y = fabs(x);

    // In this range we find the integer part y0 of y 
    // and the increment dy = y - y0. We then compute
    // z = cosh(y) = cosh(y0)cosh(dy) + sinh(y0)sinh(dy)
    // where sinh(y0) and cosh(y0) are tabulated above.

    int ind = min((int)y, 36);
    double dy = y - ind;
    double dy2 = dy * dy;

    double sdy = dy * dy2 *
	         fma(dy2,
		     fma(dy2,
			 fma(dy2,
			     fma(dy2,
				 fma(dy2,
				     fma(dy2, 0.7746188980094184251527126e-12, 0.160576793121939886190847e-9),
				     0.250521176994133472333666e-7),
				 0.275573191913636406057211e-5),
			     0.198412698413242405162014e-3),
			 0.833333333333329931873097e-2),
		     0.166666666666666667013899e0);

    double cdy = dy2 * fma(dy2,
	                   fma(dy2,
			       fma(dy2,
				   fma(dy2,
				       fma(dy2,
					   fma(dy2, 0.1163921388172173692062032e-10, 0.208744349831471353536305e-8),
					   0.275573350756016588011357e-6),
				       0.248015872460622433115785e-4),
				   0.138888888889814854814536e-2),
			       0.416666666666660876512776e-1),
			   0.500000000000000005911074e0);

    // At this point sinh(dy) is approximated by dy + sdy,
    // and cosh(dy) is approximated by 1 + cdy.
    double2 tv = cosh_tbl[ind];
    double cl = tv.s0;
    double ct = tv.s1;
    tv = sinh_tbl[ind];
    double sl = tv.s0;
    double st = tv.s1;

    double z = fma(sl, dy, fma(sl, sdy, fma(cl, cdy, fma(st, dy, fma(st, sdy, ct*cdy)) + ct))) + cl;

    // Other cases
    z = y < 0x1.0p-28 ? 1.0 : z;

    double t = exp(y - 0x1.62e42fefa3800p-1);
    t =  fma(t, -0x1.ef35793c76641p-45, t);
    z = y >= small_threshold ? t : z;

    z = y >= max_cosh_arg ? as_double(PINFBITPATT_DP64) : z;

    z = isinf(x) | isnan(x) ? y : z;

    return z;
}

