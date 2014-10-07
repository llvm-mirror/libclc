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

//    Algorithm:
//
//    e^x = 2^(x/ln(2)) = 2^(x*(64/ln(2))/64)
//
//    x*(64/ln(2)) = n + f, |f| <= 0.5, n is integer
//    n = 64*m + j,   0 <= j < 64
//
//    e^x = 2^((64*m + j + f)/64)
//        = (2^m) * (2^(j/64)) * 2^(f/64)
//        = (2^m) * (2^(j/64)) * e^(f*(ln(2)/64))
//
//    f = x*(64/ln(2)) - n
//    r = f*(ln(2)/64) = x - n*(ln(2)/64)
//
//    e^x = (2^m) * (2^(j/64)) * e^r
//
//    (2^(j/64)) is precomputed
//
//    e^r = 1 + r + (r^2)/2! + (r^3)/3! + (r^4)/4! + (r^5)/5!
//    e^r = 1 + q
//
//    q = r + (r^2)/2! + (r^3)/3! + (r^4)/4! + (r^5)/5!
//
//    e^x = (2^m) * ( (2^(j/64)) + q*(2^(j/64)) )

__attribute__((overloadable, weak)) float
#if defined(COMPILING_EXP2)
exp2(float x)
#elif defined(COMPILING_EXP10)
exp10(float x)
#else
exp(float x)
#endif
{
    USE_TABLE(float, p_tbl, EXP_TBL);

#if defined(COMPILING_EXP2)
    const float X_MAX =  0x1.fffffep+6f; // 128
    const float X_MIN = -0x1.2a0000p+7f; // -149
#elif defined(COMPILING_EXP10)
    const float X_MAX =  0x1.344134p+5f; // 128*log2/log10 : 38.53183944498959
    const float X_MIN = -0x1.66d3e8p+5f; // -149*log2/log10 : -44.8534693539332
#else
    const float X_MAX =  0x1.62e42ep+6f; // 128*log2 : 88.722839111673
    const float X_MIN = -0x1.9d1da0p+6f; // -149*log2 : -103.27892990343184
#endif

#if defined(COMPILING_EXP2)
    const float R_64 = 0x1.000000p+6f; // 2^6
    const float R_1_BY_64 = 0x1.000000p-6f; // 2^-6
    const float R_LN2 = 0x1.62e430p-1f; // 0.6931471805599453
#elif defined(COMPILING_EXP10)
    const float R_64_BY_LOG10_2 = 0x1.a934f0p+7f; // 64*log10/log2 : 212.6033980727912
    const float R_LOG10_2_BY_64_LD = 0x1.340000p-8f; // log2/(64 * log10) lead : 0.004699707
    const float R_LOG10_2_BY_64_TL = 0x1.04d426p-18f; // log2/(64 * log10) tail : 0.00000388665057
    const float R_LN10 = 0x1.26bb1cp+1f;
#else
    const float R_64_BY_LOG2 = 0x1.715476p+6f; // 64/log2 : 92.332482616893657
    const float R_LOG2_BY_64_LD = 0x1.620000p-7f; /* log2/64 lead: 0.0108032227 */
    const float R_LOG2_BY_64_TL = 0x1.c85fdep-16f; /* log2/64 tail: 0.0000272020388 */
#endif

    int return_nan = isnan(x);
    int return_inf = x > X_MAX;
    int return_zero = x < X_MIN;

#if defined(COMPILING_EXP2)
    int n = convert_int(x * R_64);
#elif defined(COMPILING_EXP10)
    int n = convert_int(x * R_64_BY_LOG10_2);
#else
    int n = convert_int(x * R_64_BY_LOG2);
#endif

    float fn = (float)n;
    int j = n & 0x3f;
    int m = n >> 6;
    int m2 = m << EXPSHIFTBITS_SP32;
    float r;

#if defined(COMPILING_EXP2)
    r = R_LN2 * mad(-R_1_BY_64, fn, x);
#elif defined(COMPILING_EXP10)
    r = R_LN10 * mad(fn, -R_LOG10_2_BY_64_TL, mad(fn, -R_LOG10_2_BY_64_LD, x));
#else
    r = mad(fn, -R_LOG2_BY_64_TL, mad(fn, -R_LOG2_BY_64_LD, x));
#endif

    // Truncated Taylor series for e^r
    float z2 = mad(mad(mad(r, 0x1.555556p-5f, 0x1.555556p-3f), r, 0x1.000000p-1f), r*r, r);

    float two_to_jby64 = p_tbl[j];
    z2 = mad(two_to_jby64, z2, two_to_jby64);

    float z2s = z2 * as_float(0x1 << (m + 149));
    float z2n = as_float(as_int(z2) + m2);
    z2 = m <= -126 ? z2s : z2n;


    z2 = return_inf ? as_float(PINFBITPATT_SP32) : z2;
    z2 = return_zero ? 0.0f : z2;
    z2 = return_nan ? x : z2;
    return z2;
}

