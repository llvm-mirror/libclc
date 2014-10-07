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
#ifndef MATH32_H
#define MATH32_H 1

extern __attribute__((pure)) float  __amdil_copysign_f32(float, float);
extern __attribute__((pure)) float  __amdil_fma_f32(float, float, float);
extern __attribute__((pure)) float  __amdil_mad_f32(float, float, float);
extern __attribute__((pure)) float  __amdil_min_f32(float, float);
extern __attribute__((pure)) float  __amdil_max_f32(float, float);
extern __attribute__((pure)) float  __ftz_f32(float);
extern __attribute__((pure)) float  __amdil_round_nearest_f32(float);
extern __attribute__((pure)) float  __amdil_round_neginf_f32(float);
extern __attribute__((pure)) float  __amdil_round_posinf_f32(float);
extern __attribute__((pure)) float  __amdil_round_zero_f32(float);
extern __attribute__((pure)) float  __amdil_fabs_f32(float);
extern __attribute__((pure)) float __amdil_improved_div_f32(float, float);
extern __attribute__((pure)) float  __amdil_fraction_f32(float);
extern __attribute__((pure)) uint  __amdil_cmov_logical_i32(uint,  uint,  uint);
extern __attribute__((pure)) uint __amdil_is_asic_id_i32(uint);
extern __attribute__((pure)) uint __amdil_is_constant_f32(float);

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

extern __attribute__((pure)) int __amdil_class_f32(float, int);

// HSA definitions for these macros
#define HAVE_HW_FMA32() (1)
#define HAVE_BITALIGN() (0)
#define HAVE_FAST_FMA32() (0)


// Allow control over how division is done
#define MATH_DIVIDE(X, Y) native_divide(X, Y)
// #define MATH_DIVIDE(X,Y) ((X) / (Y))
#define MATH_RECIP(X) native_recip(X)
// #define MATH_RECIP(X) (1.0f / (X))

// Allow control over square root
#define MATH_SQRT(X) native_sqrt(X)

// Force a flush of a subnormal to zero by feeding it through a functional unit
#define FTZ(X) __ftz_f32(X)

// Table stuff
#define TABLE_SPACE __constant

#define TABLE_MANGLE(NAME) __math32_##NAME

#define USE_TABLE(TYPE,PTR,NAME) \
    extern TABLE_SPACE TYPE TABLE_MANGLE(NAME) []; \
    TABLE_SPACE TYPE * PTR = TABLE_MANGLE(NAME)

#define DECLARE_TABLE(TYPE,NAME,LENGTH,...) \
    TABLE_SPACE TYPE TABLE_MANGLE(NAME) [ LENGTH ] = { __VA_ARGS__ };

/* These definitions, used by float functions,
   are for both 32 and 64 bit machines */
#define SIGNBIT_SP32      0x80000000
#define EXSIGNBIT_SP32    0x7fffffff
#define EXPBITS_SP32      0x7f800000
#define MANTBITS_SP32     0x007fffff
#define ONEEXPBITS_SP32   0x3f800000
#define TWOEXPBITS_SP32   0x40000000
#define HALFEXPBITS_SP32  0x3f000000
#define IMPBIT_SP32       0x00800000
#define QNANBITPATT_SP32  0x7fc00000
#define INDEFBITPATT_SP32 0xffc00000
#define PINFBITPATT_SP32  0x7f800000
#define NINFBITPATT_SP32  0xff800000
#define EXPBIAS_SP32      127
#define EXPSHIFTBITS_SP32 23
#define BIASEDEMIN_SP32   1
#define EMIN_SP32         -126
#define BIASEDEMAX_SP32   254
#define EMAX_SP32         127
#define LAMBDA_SP32       1.0e30
#define MANTLENGTH_SP32   24
#define BASEDIGITS_SP32   7

#define ALIGNED(x)	__attribute__((aligned(x)))

// Workaround a bug in the Apple linker that prevents inlining of large,
// frequently-used static functions that only have the inline attribute.
// Force all inline functions to be always_inlined.
#ifdef USE_APPLE
#define inline __attribute__((always_inline))
#endif

#endif /* MATH32_H */

