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
// Image write built-ins

// Hsail store image intrinsics
extern void __hsail_stimagef_1d_i32(float, float, float, float, image1d_t, int);
extern void __hsail_stimagei_1d_i32(int, int, int, int, image1d_t, int);
extern void __hsail_stimageui_1d_i32(uint, uint, uint, uint, image1d_t, int);

extern void __hsail_stimagef_1db_i32(float, float, float, float, image1d_buffer_t, int);
extern void __hsail_stimagei_1db_i32(int, int, int, int, image1d_buffer_t, int);
extern void __hsail_stimageui_1db_i32(uint, uint, uint, uint, image1d_buffer_t, int);

extern void __hsail_stimagef_1da_i32(float, float, float, float, image1d_array_t, int, int);
extern void __hsail_stimagei_1da_i32(int, int, int, int, image1d_array_t, int, int);
extern void __hsail_stimageui_1da_i32(uint, uint, uint, uint, image1d_array_t, int, int);

extern void __hsail_stimagef_2d_i32(float, float, float, float, image2d_t, int, int);
extern void __hsail_stimagei_2d_i32(int, int, int, int, image2d_t, int, int);
extern void __hsail_stimageui_2d_i32(uint, uint, uint, uint, image2d_t, int, int);

extern void __hsail_stimagef_2da_i32(float, float, float, float, image2d_array_t, int, int, int, int);
extern void __hsail_stimagei_2da_i32(int, int, int, int, image2d_array_t, int, int, int, int);
extern void __hsail_stimageui_2da_i32(uint, uint, uint, uint, image2d_array_t, int, int, int, int);

extern void __hsail_stimagef_3d_i32(float, float, float, float, image3d_t, int, int, int, int);
extern void __hsail_stimagei_3d_i32(int, int, int, int, image3d_t, int, int, int, int);
extern void __hsail_stimageui_3d_i32(uint, uint, uint, uint, image3d_t, int, int, int, int);


#define DefWriteImage1d(Func,HsailIntrin,CoordTy,ValTy) \
__attribute__((overloadable, always_inline)) void \
Func(image1d_t image, CoordTy coords, ValTy##4 val) { \
  HsailIntrin(val.x, val.y, val.z, val.w, image, coords); \
}

#define DefWriteImage1dBuffer(Func,HsailIntrin,CoordTy,ValTy) \
__attribute__((overloadable, always_inline)) void \
Func(image1d_buffer_t image, CoordTy coords, ValTy##4 val) { \
  HsailIntrin(val.x, val.y, val.z, val.w, image, coords); \
}

#define DefWriteImage1dArray(Func,HsailIntrin,CoordTy,ValTy) \
__attribute__((overloadable, always_inline)) void \
  Func(image1d_array_t image, CoordTy##2 coords, ValTy##4 val) { \
  HsailIntrin(val.x, val.y, val.z, val.w, image, coords.x, coords.y); \
}

#define DefWriteImage2d(Func,HsailIntrin,CoordTy,ValTy) \
__attribute__((overloadable, always_inline)) void \
Func(image2d_t image, CoordTy##2 coords, ValTy##4 val) { \
  HsailIntrin(val.x, val.y, val.z, val.w, image, coords.x, coords.y); \
}

#define DefWriteImage2dArray(Func,HsailIntrin,CoordTy,ValTy) \
__attribute__((overloadable, always_inline)) void \
Func(image2d_array_t image, CoordTy##4 coords, ValTy##4 val) { \
  HsailIntrin(val.x, val.y, val.z, val.w, image, coords.x, coords.y, coords.z, coords.w); \
}

#define DefWriteImage3d(Func,HsailIntrin,CoordTy,ValTy) \
__attribute__((overloadable, always_inline)) void \
Func(image3d_t image, CoordTy##4 coords, ValTy##4 val) { \
  HsailIntrin(val.x, val.y, val.z, val.w, image, coords.x, coords.y, coords.z, coords.w); \
}

// Write Image 1d
DefWriteImage1d(write_imagef, __hsail_stimagef_1d_i32, int, float)
DefWriteImage1d(write_imagei, __hsail_stimagei_1d_i32, int, int)
DefWriteImage1d(write_imageui, __hsail_stimageui_1d_i32, int, uint)

// Write Image 1d Array
DefWriteImage1dArray(write_imagef, __hsail_stimagef_1da_i32, int, float)
DefWriteImage1dArray(write_imagei, __hsail_stimagei_1da_i32, int, int)
DefWriteImage1dArray(write_imageui, __hsail_stimageui_1da_i32, int, uint)

// Write Image 1d Buffer
DefWriteImage1dBuffer(write_imagef, __hsail_stimagef_1db_i32, int, float)
DefWriteImage1dBuffer(write_imagei, __hsail_stimagei_1db_i32, int, int)
DefWriteImage1dBuffer(write_imageui, __hsail_stimageui_1db_i32, int, uint)

// Write Image 2d
DefWriteImage2d(write_imagef, __hsail_stimagef_2d_i32, int, float)
DefWriteImage2d(write_imagei, __hsail_stimagei_2d_i32, int, int)
DefWriteImage2d(write_imageui, __hsail_stimageui_2d_i32, int, uint)

// Write Image 2d Array
DefWriteImage2dArray(write_imagef, __hsail_stimagef_2da_i32, int, float)
DefWriteImage2dArray(write_imagei, __hsail_stimagei_2da_i32, int, int)
DefWriteImage2dArray(write_imageui, __hsail_stimageui_2da_i32, int, uint)

// Write Image 3d
DefWriteImage3d(write_imagef, __hsail_stimagef_3d_i32, int, float)
DefWriteImage3d(write_imagei, __hsail_stimagei_3d_i32, int, int)
DefWriteImage3d(write_imageui, __hsail_stimageui_3d_i32, int, uint)

#ifdef __clang__
// Image-2.0 write built-ins

// Hsail store image intrinsics
extern void __hsail_stimagef_2ddepth_i32(float, image2d_depth_t, int, int);
extern void __hsail_stimagef_2dadepth_i32(float, image2d_array_depth_t, int, int, int, int);

#define DefWriteImage2dDepth(Func, HsailIntrin, CoordTy, ValTy) \
__attribute__((overloadable, always_inline)) void \
Func(image2d_depth_t image, CoordTy##2 coords, ValTy val) { \
  HsailIntrin(val, image, coords.x, coords.y); \
}

#define DefWriteImage2dArrayDepth(Func, HsailIntrin, CoordTy, ValTy) \
__attribute__((overloadable, always_inline)) void \
Func(image2d_array_depth_t image, CoordTy##4 coords, ValTy val) { \
  HsailIntrin(val, image, coords.x, coords.y, coords.z, coords.w); \
}

// Write Image 2d Depth
DefWriteImage2dDepth(write_imagef, __hsail_stimagef_2ddepth_i32, int, float)

// Write Image 2d Array Depth
DefWriteImage2dArrayDepth(write_imagef, __hsail_stimagef_2dadepth_i32, int, float)

#endif