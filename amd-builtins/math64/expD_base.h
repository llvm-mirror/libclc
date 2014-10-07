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

//   Algorithm:
//
//   e^x = 2^(x/ln(2)) = 2^(x*(64/ln(2))/64)
//
//   x*(64/ln(2)) = n + f, |f| <= 0.5, n is integer
//   n = 64*m + j,   0 <= j < 64
//
//   e^x = 2^((64*m + j + f)/64)
//       = (2^m) * (2^(j/64)) * 2^(f/64)
//       = (2^m) * (2^(j/64)) * e^(f*(ln(2)/64))
//
//   f = x*(64/ln(2)) - n
//   r = f*(ln(2)/64) = x - n*(ln(2)/64)
//
//   e^x = (2^m) * (2^(j/64)) * e^r
//
//   (2^(j/64)) is precomputed
//
//   e^r = 1 + r + (r^2)/2! + (r^3)/3! + (r^4)/4! + (r^5)/5!
//   e^r = 1 + q
//
//   q = r + (r^2)/2! + (r^3)/3! + (r^4)/4! + (r^5)/5!
//
//   e^x = (2^m) * ( (2^(j/64)) + q*(2^(j/64)) )

__attribute__((overloadable, always_inline, weak)) double
#if defined COMPILING_EXP2
exp2(double x)
#elif defined COMPILING_EXP10
exp10(double x)
#else
exp(double x)
#endif
{
    USE_TABLE(double2, p_tbl, TWO_TO_JBY64_EP);

#if defined(COMPILING_EXP2)
    const double X_MAX = 1024.0;
    const double X_MIN = -1074;
#elif defined(COMPILING_EXP10)
    const double X_MAX = 0x1.34413509f79ffp+8; // 1024*ln(2)/ln(10)
    const double X_MIN = -0x1.434e6420f4374p+8; // -1074*ln(2)/ln(10)
#else
    const double X_MAX = 0x1.62e42fefa39efp+9; // 1024*ln(2)
    const double X_MIN = -0x1.74910d52d3051p+9; // -1075*ln(2)
#endif

#if defined(COMPILING_EXP2)
    const double R_64 = 64.0;
    const double R_1_BY_64 = 1.0 / 64.0;
    const double R_LN2 = 0x1.62e42fefa39efp-1; // ln(2)
#elif defined(COMPILING_EXP10)
    const double R_64_BY_LOG10_2 = 0x1.a934f0979a371p+7; // 64*ln(10)/ln(2)
    const double R_LOG10_2_BY_64_LD = 0x1.3441350000000p-8; // head ln(2)/(64*ln(10))
    const double R_LOG10_2_BY_64_TL = 0x1.3ef3fde623e25p-37; // tail ln(2)/(64*ln(10))
    const double R_LN10 = 0x1.26bb1bbb55516p+1; // ln(10)
#else
    const double R_64_BY_LOG2 = 0x1.71547652b82fep+6; // 64/ln(2)
    const double R_LOG2_BY_64_LD = 0x1.62e42fefa0000p-7; // head ln(2)/64
    const double R_LOG2_BY_64_TL = 0x1.cf79abc9e3b39p-46; // tail ln(2)/64
#endif

#if defined(COMPILING_EXP2)
    int n = convert_int(x * R_64);
#elif defined(COMPILING_EXP10)
    int n = convert_int(x * R_64_BY_LOG10_2);
#else
    int n = convert_int(x * R_64_BY_LOG2);
#endif

    double dn = (double)n;

    int j = n & 0x3f;
    int m = n >> 6;

#if defined(COMPILING_EXP2)
    double r = R_LN2 * fma(-R_1_BY_64, dn, x);
#elif defined(COMPILING_EXP10)
    double r = R_LN10 * fma(-R_LOG10_2_BY_64_TL, dn, fma(-R_LOG10_2_BY_64_LD, dn, x));
#else
    double r = fma(-R_LOG2_BY_64_TL, dn, fma(-R_LOG2_BY_64_LD, dn, x));
#endif

    // 6 term tail of Taylor expansion of e^r
    double z2 = r * fma(r,
	                fma(r,
		            fma(r,
			        fma(r,
			            fma(r, 0x1.6c16c16c16c17p-10, 0x1.1111111111111p-7),
			            0x1.5555555555555p-5),
			        0x1.5555555555555p-3),
		            0x1.0000000000000p-1),
		        1.0);

    double2 tv = p_tbl[j];
    z2 = fma(tv.s0 + tv.s1, z2, tv.s1) + tv.s0;

    int small_value = (m < -1022) || ((m == -1022) && (z2 < 1.0));

	int n1 = m >> 2;
	int n2 = m-n1;
	double z3= z2 * as_double(((long)n1 + 1023) << 52);
	z3 *= as_double(((long)n2 + 1023) << 52);

    z2 = ldexp(z2, m);
    z2 = small_value ? z3: z2;

    z2 = isnan(x) ? x : z2;

    z2 = x > X_MAX ? as_double(PINFBITPATT_DP64) : z2;
    z2 = x < X_MIN ? 0.0 : z2;

    return z2;
}

