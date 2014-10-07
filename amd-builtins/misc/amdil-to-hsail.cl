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
// __amdil_ to __hsail_ translation  

// HSAIL intrinsic functions used by math32 functions
extern __attribute__((pure)) float __hsail_fma_f32(float, float, float);
extern __attribute__((pure)) float __hsail_nfma_f32(float, float, float);
extern __attribute__((pure)) float __hsail_min_f32(float, float);
extern __attribute__((pure)) float __hsail_max_f32(float, float);
extern __attribute__((pure)) float __hsail_ftz_f32(float);
extern __attribute__((pure)) float __hsail_round_f32(float);
extern __attribute__((pure)) float __hsail_floor_f32(float);
extern __attribute__((pure)) float __hsail_ceil_f32(float);
extern __attribute__((pure)) float __hsail_trunc_f32(float);
extern __attribute__((pure)) float __hsail_abs_f32(float);

extern __attribute__((pure)) int  __hsail_min_s32(int, int);
extern __attribute__((pure)) int  __hsail_max_s32(int, int);
extern __attribute__((pure)) uint __hsail_min_u32(uint, int);
extern __attribute__((pure)) uint __hsail_max_u32(uint, uint);
extern __attribute__((pure)) int  __hsail_mulhi_s32(int, int);
extern __attribute__((pure)) uint __hsail_mulhi_u32(uint, uint);
extern __attribute__((pure)) int  __hsail_mulhi_s64(int, int);
extern __attribute__((pure)) uint __hsail_mulhi_u64(uint, uint);

// HSAIL intrinsic functions used by math64 functions
extern __attribute__((pure)) double __hsail_fma_f64(double, double, double);
extern __attribute__((pure)) double __hsail_nfma_f64(double, double, double);
extern __attribute__((pure)) double __hsail_max_f64(double, double);
extern __attribute__((pure)) double __hsail_min_f64(double, double);
extern __attribute__((pure)) double __hsail_round_f64(double);
extern __attribute__((pure)) double __hsail_floor_f64(double);
extern __attribute__((pure)) double __hsail_ceil_f64(double);
extern __attribute__((pure)) double __hsail_trunc_f64(double);
extern __attribute__((pure)) double __hsail_abs_f64(double);
extern __attribute__((pure)) double __hsail_nrsqrt_f64(double);
extern __attribute__((pure)) double __hsail_nsqrt_f64(double);

extern __attribute__((pure)) uint __hsail_mad_u32(uint, uint, uint);

// HSAIL conversion intrinsics
extern __attribute__((pure)) float __cvt_f32_f16(uint op1);

extern __attribute__((pure)) float __cvt_f16_rtz_f32(float op1);
extern __attribute__((pure)) float __cvt_f16_rte_f32(float op1);
extern __attribute__((pure)) float __cvt_f16_rtn_f32(float op1);
extern __attribute__((pure)) float __cvt_f16_rtp_f32(float op1);

extern __attribute__((pure)) float __cvt_f16_rtz_f64(double op1);
extern __attribute__((pure)) float __cvt_f16_rte_f64(double op1);
extern __attribute__((pure)) float __cvt_f16_rtn_f64(double op1);
extern __attribute__((pure)) float __cvt_f16_rtp_f64(double op1);

// Misc HSAIL intrinsic functions
extern __attribute__((const)) uint __hsail_bitselect_u32(uint, uint, uint);
extern __attribute__((pure)) int  __hsail_class_f32(float, int);
extern __attribute__((pure)) int  __hsail_class_f64(double, int);
extern __attribute__((pure)) int  __hsail_mad24_s32(int, int, int);
extern __attribute__((pure)) uint __hsail_mad24_u32(uint, uint, uint);
extern __attribute__((pure)) int  __hsail_mul24_s32(int, int);
extern __attribute__((pure)) uint __hsail_mul24_u32(uint, uint);

extern __attribute__((pure)) int __hsail_popcount_u32_b32(int);

extern __attribute__((pure)) int __hsail_firstbit_u32(uint);

extern __attribute__((pure)) float  __hsail_fraction_f32(float);
extern __attribute__((pure)) double __hsail_fraction_f64(double);

// __amdil_ math32 function defs

__attribute__((weak,always_inline)) float
__amdil_div_f32(float x, float y) {
  return native_divide(x, y);
}

__attribute__((weak,always_inline)) float
__amdil_fma_f32(float x, float y, float z) {
  return __hsail_fma_f32(x, y, z);
}

__attribute__((weak,always_inline)) float
__amdil_mad_f32(float x, float y, float z) {
  return __hsail_nfma_f32(x, y, z);
}

__attribute__((weak,always_inline)) float
__amdil_min_f32(float x, float y) {
  return __hsail_min_f32(x, y);
}

__attribute__((weak,always_inline)) float
__amdil_max_f32(float x, float y) {
  return __hsail_max_f32(x, y);
}

__attribute__((weak,always_inline)) float
__ftz_f32(float x) {
  return __hsail_ftz_f32(x);
}

__attribute__((weak,always_inline)) float
__amdil_round_nearest_f32(float x) {
  return __hsail_round_f32(x);
}

__attribute__((weak,always_inline)) float
__amdil_round_neginf_f32(float x) {
  return __hsail_floor_f32(x);
}

__attribute__((weak,always_inline)) float
__amdil_round_posinf_f32(float x) {
  return __hsail_ceil_f32(x);
}

__attribute__((weak,always_inline)) float
__amdil_round_zero_f32(float x) {
  return __hsail_trunc_f32(x);
}

__attribute__((weak,always_inline)) float
__amdil_fabs_f32(float x) {
  return __hsail_abs_f32(x);
}

__attribute__((weak,always_inline)) float
__amdil_improved_div_f32(float x, float y) {
  return native_divide(x, y);
}

__attribute__((weak,always_inline)) int
__amdil_imin_i32(int x, int y) {
  return __hsail_min_s32(x, y);
}

__attribute__((weak,always_inline)) int
__amdil_imax_i32(int x, int y) {
  return __hsail_max_s32(x, y);
}

__attribute__((weak,always_inline)) uint
__amdil_umin_u32(uint x, uint y) {
  return __hsail_min_u32(x, y);
}

__attribute__((weak,always_inline)) uint
__amdil_umax_u32(uint x, uint y) {
  return __hsail_max_u32(x, y);
}

__attribute__((weak,always_inline)) int
__amdil_imul_high_i32(int x, int y) {
  return __hsail_mulhi_s32(x, y);
}

__attribute__((weak,always_inline)) uint
__amdil_umul_high_u32(uint x, uint y) {
  return __hsail_mulhi_u32(x, y);
}

__attribute__((weak,always_inline)) uint 
__amdil_umad_u32(uint x, uint y, uint z) {
  return __hsail_mad_u32(x, y, z);
}

// __amdil_ math64 function defs

__attribute__((weak,always_inline)) double
__amdil_fma_f64(double x, double y, double z) {
  return __hsail_fma_f64(x, y, z);
}

__attribute__((weak,always_inline)) double
__amdil_mad_f64(double x, double y, double z) {
  return __hsail_nfma_f64(x, y, z);
}

 __attribute__((weak,always_inline)) double
__amdil_max_f64(double x, double y) {
  return __hsail_max_f64(x, y);
}

__attribute__((weak,always_inline)) double
__amdil_round_nearest_f64(double x) {
  return __hsail_round_f64(x);
}

__attribute__((weak,always_inline)) double
__amdil_round_neginf_f64(double x) {
  return __hsail_floor_f64(x);
}

__attribute__((weak,always_inline)) double
__amdil_round_posinf_f64(double x) {
  return __hsail_ceil_f64(x);
}

__attribute__((weak,always_inline)) double
__amdil_round_zero_f64(double x) {
  return __hsail_trunc_f64(x);
}

 __attribute__((weak,always_inline)) double
__amdil_min_f64(double x, double y) {
  return __hsail_min_f64(x, y);
}

__attribute__((weak,always_inline)) double
__amdil_fabs_f64(double x) {
  return __hsail_abs_f64(x);
}

__attribute__((weak,always_inline)) double
__amdil_sqrt_f64(double x) {
  return __hsail_nsqrt_f64(x);
}

__attribute__((weak,always_inline)) double
__amdil_rsq_f64(double x) {
  return __hsail_nrsqrt_f64(x);
}

// __amdil conversion functions

__attribute__((weak,always_inline)) float 
__amdil_half_to_float_f32(uint x) {
  return __cvt_f32_f16(x);
}

__attribute__((weak,always_inline)) float 
__amdil_float_to_half_f32(float x) {
  return __cvt_f16_rtz_f32(x);
}

__attribute__((weak,always_inline)) float 
__amdil_float_to_half_near_f32(float x) {
  return __cvt_f16_rte_f32(x);
}

__attribute__((weak,always_inline)) float 
__amdil_float_to_half_neg_inf_f32(float x) {
  return __cvt_f16_rtn_f32(x);
}

__attribute__((weak,always_inline)) float 
__amdil_float_to_half_plus_inf_f32(float x) {
  return __cvt_f16_rtp_f32(x);
}

__attribute__((weak,always_inline)) float 
__amdil_double_to_half_f64(double x) {
  return __cvt_f16_rtz_f64(x);
}

__attribute__((weak,always_inline)) float 
__amdil_double_to_half_near_f64(double x) {
  return __cvt_f16_rte_f64(x);
}

__attribute__((weak,always_inline)) float 
__amdil_double_to_half_neg_inf_f64(double x) {
  return __cvt_f16_rtn_f64(x);
}

__attribute__((weak,always_inline)) float 
__amdil_double_to_half_plus_inf_f64(double x) {
  return __cvt_f16_rtp_f64(x);
}

// Misc __amdil_ function defs

__attribute__((weak,always_inline)) uint
__amdil_bfi_u32(uint x, uint y, uint z) {
  return __hsail_bitselect_u32(x, y, z);
}

__attribute__((weak,always_inline)) int
__amdil_class_f32(float x, int y) {
  int cval = __hsail_class_f32(x, y);
  int ret = (cval & 0x1) ? (0xffffffffU) : 0;
  return ret;
}

__attribute__((weak,always_inline)) int
__amdil_class_f64(double x, int y) {
  int cval = __hsail_class_f64(x, y);
  int ret = (cval & 0x1) ? (0xffffffffU) : 0;
  return ret;
}

__attribute__((weak,always_inline)) int 
__amdil_imad24_i32(int x, int y, int z) {
  return __hsail_mad24_s32(x, y, z);
}

__attribute__((weak,always_inline)) uint 
__amdil_umad24_u32(uint x, uint y, uint z) {
  return __hsail_mad24_u32(x, y, z);
}

__attribute__((weak,always_inline)) int 
__amdil_imul24_i32(int x, int y) {
  return __hsail_mul24_s32(x, y);
}

__attribute__((weak,always_inline)) uint 
__amdil_umul24_u32(uint x, uint y) {
  return __hsail_mul24_u32(x, y);
}

__attribute__((weak,always_inline)) int
__amdil_count_bits_i32(int x) {
  return __hsail_popcount_u32_b32(x);
}

__attribute__((weak,always_inline)) int
__amdil_ffb_hi_u32(uint x) {
  return __hsail_firstbit_u32(x);
}

//#ifdef HSAIL_SPEC_CURRENT
__attribute__((weak,always_inline)) float
__amdil_fraction_f32(float x) {
  return __hsail_fraction_f32(x);
}

__attribute__((weak,always_inline)) double
__amdil_fraction_f64(double x) {
  return __hsail_fraction_f64(x);
}
//#endif 

