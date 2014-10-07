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
#pragma OPENCL EXTENSION cl_amd_media_ops : enable

extern __attribute__((const)) uint __hsail_bitalign_b32(uint, uint, uint);

extern __attribute__((const)) uint __hsail_bytealign_b32(uint, uint, uint);

extern __attribute__((pure)) uint  __hsail_packcvt_u8x4_f32(float,float,float,float);

extern __attribute__((pure)) uint __hsail_lerp_u8x4(uint,uint,uint);

extern __attribute__((pure)) uint __hsail_sad_u32_u8x4(uint,uint,uint);

extern __attribute__((pure)) uint __hsail_sadhi_u16x2_u8x4(uint,uint,uint);

extern __attribute__((pure)) float __hsail_unpackcvt_f32_u8x4(uint,uint);

extern __attribute__((const)) uint __hsail_msad(uint,uint,uint);

extern __attribute__((const)) uint __hsail_sadd(uint,uint,uint);

extern __attribute__((const)) uint __hsail_sadw(uint,uint,uint);

extern __attribute__((const)) uint __hsail_umin3(uint,uint,uint);

extern __attribute__((const)) int __hsail_imin3(int,int,int);

extern __attribute__((const)) uint __hsail_umax3(uint,uint,uint);

extern __attribute__((const)) int __hsail_imax3(int,int,int);

extern __attribute__((const)) uint __hsail_umedian3(uint,uint,uint);

extern __attribute__((const)) int __hsail_imedian3(int,int,int);

extern __attribute__((const)) uint __hsail_bfe(uint,uint,uint);

extern __attribute__((const)) float __hsail_f32_min3(float,float,float);

extern __attribute__((const)) float __hsail_f32_max3(float,float,float);

extern __attribute__((const)) float __hsail_f32_median3(float,float,float);

extern __attribute__((const)) ulong __hsail_mqsad(ulong,uint,ulong);

extern __attribute__((const)) ulong __hsail_qsad(ulong,uint,ulong);

extern __attribute__((const)) uint __hsail_bfm(uint,uint);

extern __attribute__((const)) int __hsail_ibfe(int,uint,uint);
