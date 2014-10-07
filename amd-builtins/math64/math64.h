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
#ifndef MATH64_H
#define MATH64_H 1

extern __attribute__((pure)) double __amdil_copysign_f64(double, double);
extern __attribute__((pure)) double __amdil_fma_f64(double, double, double);
extern __attribute__((pure)) double __amdil_mad_f64(double, double, double);
extern __attribute__((pure)) double __amdil_max_f64(double, double);
extern __attribute__((pure)) double __amdil_min_f64(double, double);
extern __attribute__((pure)) double __amdil_fraction_f64(double);
extern __attribute__((pure)) double __amdil_fabs_f64(double);
extern __attribute__((pure)) double __amdil_round_nearest_f64(double);
extern __attribute__((pure)) double __amdil_round_neginf_f64(double);
extern __attribute__((pure)) double __amdil_round_posinf_f64(double);
extern __attribute__((pure)) double __amdil_round_zero_f64(double);
extern __attribute__((pure)) double __amdil_rsq_f64(double);

extern __attribute__((pure)) int __amdil_class_f64(double, int);

#define SNAN 0x001
#define QNAN 0x002
#define NINF 0x004
#define NNOR 0x008
#define NSUB 0x010
#define NZER 0x020
#define PZER 0x040
#define PSUB 0x080
#define PNOR 0x100
#define PINF 0x200

// Allow control over how division is done
#define MATH_DIVIDE(X,Y) ((X) / (Y))
#define MATH_RECIP(X) (1.0 / (X))

// // Allow control over square root
#define MATH_SQRT(X) sqrt(X)

// Table stuff
#define TABLE_SPACE __constant

#define TABLE_MANGLE(NAME) __math64_##NAME

#define USE_TABLE(TYPE,PTR,NAME) \
    extern TABLE_SPACE TYPE TABLE_MANGLE(NAME) []; \
    TABLE_SPACE TYPE * PTR = TABLE_MANGLE(NAME)

#define DECLARE_TABLE(TYPE,NAME,LENGTH,...) \
    TABLE_SPACE TYPE TABLE_MANGLE(NAME) [ LENGTH ] = { __VA_ARGS__ };

/* Definitions for double functions on 64 bit machines */
#define SIGNBIT_DP64      0x8000000000000000L
#define EXSIGNBIT_DP64    0x7fffffffffffffffL
#define EXPBITS_DP64      0x7ff0000000000000L
#define MANTBITS_DP64     0x000fffffffffffffL
#define ONEEXPBITS_DP64   0x3ff0000000000000L
#define TWOEXPBITS_DP64   0x4000000000000000L
#define HALFEXPBITS_DP64  0x3fe0000000000000L
#define IMPBIT_DP64       0x0010000000000000L
#define QNANBITPATT_DP64  0x7ff8000000000000L
#define INDEFBITPATT_DP64 0xfff8000000000000L
#define PINFBITPATT_DP64  0x7ff0000000000000L
#define NINFBITPATT_DP64  0xfff0000000000000L
#define EXPBIAS_DP64      1023
#define EXPSHIFTBITS_DP64 52
#define BIASEDEMIN_DP64   1
#define EMIN_DP64         -1022
#define BIASEDEMAX_DP64   2046 /* 0x7fe */
#define EMAX_DP64         1023 /* 0x3ff */
#define LAMBDA_DP64       1.0e300
#define MANTLENGTH_DP64   53
#define BASEDIGITS_DP64   15

#define ALIGNED(x)	__attribute__((aligned(x)))

#endif /* MATH64_H */

