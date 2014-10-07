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
expm1(double x)
{
    USE_TABLE(double2, p_tbl, TWO_TO_JBY64_EP);

    const double max_expm1_arg = 709.8;
    const double min_expm1_arg = -37.42994775023704;
    const double log_OnePlus_OneByFour = 0.22314355131420976;   //0x3FCC8FF7C79A9A22 = log(1+1/4)
    const double log_OneMinus_OneByFour = -0.28768207245178096; //0xBFD269621134DB93 = log(1-1/4)
    const double sixtyfour_by_lnof2 = 92.33248261689366;        //0x40571547652b82fe
    const double lnof2_by_64_head = 0.010830424696223417;       //0x3f862e42fefa0000
    const double lnof2_by_64_tail = 2.5728046223276688e-14;     //0x3d1cf79abc9e3b39


    // First, assume log(1-1/4) < x < log(1+1/4) i.e  -0.28768 < x < 0.22314
    double u = as_double(as_ulong(x) & 0xffffffffff000000UL);
    double v = x - u;
    double y = u * u * 0.5;
    double z = v * (x + u) * 0.5;

    double q = fma(x,
	           fma(x,
		       fma(x,
			   fma(x,
			       fma(x,
				   fma(x,
				       fma(x,
					   fma(x,2.4360682937111612e-8, 2.7582184028154370e-7),
					   2.7558212415361945e-6),
				       2.4801576918453420e-5),
				   1.9841269447671544e-4),
			       1.3888888890687830e-3),
			   8.3333333334012270e-3),
		       4.1666666666665560e-2),
		   1.6666666666666632e-1);
    q *= x * x * x;

    double z1g = (u + y) + (q + (v + z));
    double z1 = x + (y + (q + z));
    z1 = y >= 0x1.0p-7 ? z1g : z1;

    // Now assume outside interval around 0
    int n = (int)(x * sixtyfour_by_lnof2);
    int j = n & 0x3f;
    int m = n >> 6;

    double2 tv = p_tbl[j];
    double f1 = tv.s0;
    double f2 = tv.s1;
    double f = f1 + f2;

    double dn = -n;
    double r = fma(dn, lnof2_by_64_tail, fma(dn, lnof2_by_64_head, x));

    q = fma(r,
	    fma(r,
		fma(r,
		    fma(r, 1.38889490863777199667e-03, 8.33336798434219616221e-03),
		    4.16666666662260795726e-02),
		1.66666666665260878863e-01),
	     5.00000000000000008883e-01);
    q = fma(r*r, q, r);

    double twopm = as_double((long)(m + EXPBIAS_DP64) << EXPSHIFTBITS_DP64);
    double twopmm = as_double((long)(EXPBIAS_DP64 - m) << EXPSHIFTBITS_DP64);

    // Computations for m > 52, including where result is close to Inf
    ulong uval = as_ulong(0x1.0p+1023 * (f1 + (f * q + (f2))));
    int e = (int)(uval >> EXPSHIFTBITS_DP64) + 1;

    double zme1024 = as_double(((long)e << EXPSHIFTBITS_DP64) | (uval & MANTBITS_DP64));
    zme1024 = e == 2047 ? as_double(PINFBITPATT_DP64) : zme1024;

    double zmg52 = twopm * (f1 + fma(f, q, f2 - twopmm));
    zmg52 = m == 1024 ? zme1024 : zmg52;

    // For m < 53
    double zml53 = twopm * ((f1 - twopmm) + fma(f1, q, f2*(1.0 + q)));

    // For m < -7
    double zmln7 = fma(twopm,  f1 + fma(f, q, f2), -1.0);

    z = m < 53 ? zml53 : zmg52;
    z = m < -7 ? zmln7 : z;
    z = x > log_OneMinus_OneByFour & x < log_OnePlus_OneByFour ? z1 : z;
    z = x > max_expm1_arg ? as_double(PINFBITPATT_DP64) : z;
    z = x < min_expm1_arg ? -1.0 : z;

    return z;
}

