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

// Image read built-ins

struct pixel_data_f32 {
  float x;
  float y;
  float z;
  float w;
};

struct pixel_data_s32 {
  int x;
  int y;
  int z;
  int w;
};

struct pixel_data_u32 {
  uint x;
  uint y;
  uint z;
  uint w;
};

// Read Image 1d

#define DefReadImage1D(Func, HsailIntrin, DstTy, CoordTy, DstSuf)       \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image1d_t, sampler_t, CoordTy);                           \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image1d_t image, sampler_t sampler, CoordTy coord) {             \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, sampler, coord);                        \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefReadImage1D(read_imagef, __hsail_rdimagef_1d_s32, float, int, _f32)
DefReadImage1D(read_imagef, __hsail_rdimagef_1d_f32, float, float, _f32)
DefReadImage1D(read_imagei, __hsail_rdimagei_1d_s32, int, int, _s32)
DefReadImage1D(read_imagei, __hsail_rdimagei_1d_f32, int, float, _s32)
DefReadImage1D(read_imageui, __hsail_rdimageui_1d_s32, uint, int, _u32)
DefReadImage1D(read_imageui, __hsail_rdimageui_1d_f32, uint, float, _u32)

// Read Image 1d Array

#define DefReadImage1DArray(Func, HsailIntrin, DstTy, CoordTy, DstSuf)  \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image1d_array_t, sampler_t, CoordTy, CoordTy);            \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image1d_array_t image, sampler_t sampler, CoordTy##2 coords) {   \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, sampler, coords.x, coords.y);           \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefReadImage1DArray(read_imagef, __hsail_rdimagef_1da_s32, float, int, _f32)
DefReadImage1DArray(read_imagef, __hsail_rdimagef_1da_f32, float, float, _f32)
DefReadImage1DArray(read_imagei, __hsail_rdimagei_1da_s32, int, int, _s32)
DefReadImage1DArray(read_imagei, __hsail_rdimagei_1da_f32, int, float, _s32)
DefReadImage1DArray(read_imageui, __hsail_rdimageui_1da_s32, uint, int, _u32)
DefReadImage1DArray(read_imageui, __hsail_rdimageui_1da_f32, uint, float, _u32)

// Read Image 2d 

#define DefReadImage2D(Func, HsailIntrin, DstTy, CoordTy, DstSuf)       \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image2d_t, sampler_t, CoordTy, CoordTy);                  \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image2d_t image, sampler_t sampler, CoordTy##2 coords) {         \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, sampler, coords.x, coords.y);           \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
}

DefReadImage2D(read_imagef, __hsail_rdimagef_2d_s32, float, int, _f32)
DefReadImage2D(read_imagef, __hsail_rdimagef_2d_f32, float, float, _f32)
DefReadImage2D(read_imagei, __hsail_rdimagei_2d_s32, int, int, _s32)
DefReadImage2D(read_imagei, __hsail_rdimagei_2d_f32, int, float, _s32)
DefReadImage2D(read_imageui, __hsail_rdimageui_2d_s32, uint, int, _u32)
DefReadImage2D(read_imageui, __hsail_rdimageui_2d_f32, uint, float, _u32)

// Read Image 2d Array

#define DefReadImage2DArray(Func, HsailIntrin, DstTy, CoordTy, DstSuf)  \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image2d_array_t, sampler_t, CoordTy, CoordTy, CoordTy);   \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image2d_array_t image, sampler_t sampler, CoordTy##4 coords) {   \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, sampler, coords.x, coords.y, coords.z); \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefReadImage2DArray(read_imagef, __hsail_rdimagef_2da_s32, float, int, _f32)
DefReadImage2DArray(read_imagef, __hsail_rdimagef_2da_f32, float, float, _f32)
DefReadImage2DArray(read_imagei, __hsail_rdimagei_2da_s32, int, int, _s32)
DefReadImage2DArray(read_imagei, __hsail_rdimagei_2da_f32, int, float, _s32)
DefReadImage2DArray(read_imageui, __hsail_rdimageui_2da_s32, uint, int, _u32)
DefReadImage2DArray(read_imageui, __hsail_rdimageui_2da_f32, uint, float, _u32)

// Read Image 3d

#define DefReadImage3D(Func, HsailIntrin, DstTy, CoordTy, DstSuf)       \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image3d_t, sampler_t, CoordTy, CoordTy, CoordTy);         \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image3d_t image, sampler_t sampler, CoordTy##4 coords) {         \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, sampler, coords.x, coords.y, coords.z); \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefReadImage3D(read_imagef, __hsail_rdimagef_3d_s32, float, int, _f32)
DefReadImage3D(read_imagef, __hsail_rdimagef_3d_f32, float, float, _f32)
DefReadImage3D(read_imagei, __hsail_rdimagei_3d_s32, int, int, _s32)
DefReadImage3D(read_imagei, __hsail_rdimagei_3d_f32, int, float, _s32)
DefReadImage3D(read_imageui, __hsail_rdimageui_3d_s32, uint, int, _u32)
DefReadImage3D(read_imageui, __hsail_rdimageui_3d_f32, uint, float, _u32)

// Sampler-less Read Image 1d

#define DefLoadImage1D(Func, HsailIntrin, DstTy, CoordTy, DstSuf)       \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image1d_t, CoordTy);                                      \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image1d_t image, CoordTy coord) {                                \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, coord);                                 \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefLoadImage1D(read_imagef, __hsail_ldimagef_1d_u32, float, int, _f32)
DefLoadImage1D(read_imagei, __hsail_ldimagei_1d_u32, int, int, _s32)
DefLoadImage1D(read_imageui, __hsail_ldimageui_1d_u32, uint, int, _u32)

// Sampler-less Read Image 1d buffer

#define DefLoadImage1DBuffer(Func, HsailIntrin, DstTy, CoordTy, DstSuf) \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image1d_buffer_t, CoordTy);                               \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image1d_buffer_t image, CoordTy coord) {                         \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, coord);                                 \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefLoadImage1DBuffer(read_imagef, __hsail_ldimagef_1db_u32, float, int, _f32)
DefLoadImage1DBuffer(read_imagei, __hsail_ldimagei_1db_u32, int, int, _s32)
DefLoadImage1DBuffer(read_imageui, __hsail_ldimageui_1db_u32, uint, int, _u32)

// Sampler-less Read Image 1d Array

#define DefLoadImage1DArray(Func, HsailIntrin, DstTy, CoordTy, DstSuf)  \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image1d_array_t, CoordTy, CoordTy);                       \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image1d_array_t image, CoordTy##2 coords) {                      \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, coords.x, coords.y);                    \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefLoadImage1DArray(read_imagef, __hsail_ldimagef_1da_u32, float, int, _f32)
DefLoadImage1DArray(read_imagei, __hsail_ldimagei_1da_u32, int, int, _s32)
DefLoadImage1DArray(read_imageui, __hsail_ldimageui_1da_u32, uint, int, _u32)

// Sampler-less Read Image 2d

#define DefLoadImage2D(Func, HsailIntrin, DstTy, CoordTy, DstSuf)       \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image2d_t, CoordTy, CoordTy);                             \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image2d_t image, CoordTy##2 coords) {                            \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, coords.x, coords.y);                    \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefLoadImage2D(read_imagef, __hsail_ldimagef_2d_u32, float, int, _f32)
DefLoadImage2D(read_imagei, __hsail_ldimagei_2d_u32, int, int, _s32)
DefLoadImage2D(read_imageui, __hsail_ldimageui_2d_u32, uint, int, _u32)

// Sampler-less Read Image 2d array

#define DefLoadImage2DArray(Func, HsailIntrin, DstTy, CoordTy, DstSuf)  \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image2d_array_t, CoordTy, CoordTy, CoordTy);              \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image2d_array_t image, CoordTy##4 coords) {                      \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, coords.x, coords.y, coords.z);          \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefLoadImage2DArray(read_imagef, __hsail_ldimagef_2da_u32, float, int, _f32)
DefLoadImage2DArray(read_imagei, __hsail_ldimagei_2da_u32, int, int, _s32)
DefLoadImage2DArray(read_imageui, __hsail_ldimageui_2da_u32, uint, int, _u32)

// Sampler-less Read Image 3d

#define DefLoadImage3D(Func, HsailIntrin, DstTy, CoordTy, DstSuf)  \
  extern struct pixel_data##DstSuf                                      \
  HsailIntrin(image3d_t, CoordTy, CoordTy, CoordTy);                    \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy##4                 \
  Func(image3d_t image, CoordTy##4 coords) {                            \
    struct pixel_data##DstSuf                                           \
      data = HsailIntrin(image, coords.x, coords.y, coords.z);          \
    return (DstTy##4)(data.x, data.y, data.z, data.w);                  \
  }

DefLoadImage3D(read_imagef, __hsail_ldimagef_3d_u32, float, int, _f32)
DefLoadImage3D(read_imagei, __hsail_ldimagei_3d_u32, int, int, _s32)
DefLoadImage3D(read_imageui, __hsail_ldimageui_3d_u32, uint, int, _u32)

#if __OPENCL_C_VERSION__ >= 200
// Image-2.0 read built-ins

// Read Image 2d depth
#define DefReadImage2DDepth(Func, HsailIntrin, DstTy, CoordTy)          \
  float                                                                 \
   HsailIntrin(image2d_depth_t, sampler_t, CoordTy, CoordTy);           \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy                    \
  Func(image2d_depth_t image, sampler_t sampler, CoordTy##2 coords) {   \
    float                                                               \
      data = HsailIntrin(image, sampler, coords.x, coords.y);           \
    return data;                                                        \
}

DefReadImage2DDepth(read_imagef, __hsail_rdimagef_2ddepth_s32, float, int)
DefReadImage2DDepth(read_imagef, __hsail_rdimagef_2ddepth_f32, float, float)

// Read Image 2d array depth

#define DefReadImage2DArrayDepth(Func, HsailIntrin, DstTy, CoordTy)                  \
  float                                                                              \
   HsailIntrin(image2d_array_depth_t, sampler_t, CoordTy, CoordTy, CoordTy);         \
                                                                                     \
  __attribute__((overloadable, always_inline)) DstTy                                 \
  Func(image2d_array_depth_t image, sampler_t sampler, CoordTy##4 coords) {          \
    float                                                                            \
      data = HsailIntrin(image, sampler, coords.x, coords.y, coords.z);              \
    return data;                                                                     \
}

DefReadImage2DArrayDepth(read_imagef, __hsail_rdimagef_2dadepth_s32, float, int)
DefReadImage2DArrayDepth(read_imagef, __hsail_rdimagef_2dadepth_f32, float, float)


// Sampler-less Read Image 2d depth
#define DefLoadImage2DDepth(Func, HsailIntrin, DstTy, CoordTy)          \
  float                                                                 \
   HsailIntrin(image2d_depth_t, CoordTy, CoordTy);                      \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy                    \
  Func(image2d_depth_t image, CoordTy##2 coords) {                      \
    float                                                               \
      data = HsailIntrin(image, coords.x, coords.y);                    \
    return data;                                                        \
}

DefLoadImage2DDepth(read_imagef, __hsail_ldimagef_2ddepth_u32, float, int)

// Sampler-less Read Image 2d array depth

#define DefLoadImage2DArrayDepth(Func, HsailIntrin, DstTy, CoordTy)     \
  float                                                                 \
   HsailIntrin(image2d_array_depth_t, CoordTy, CoordTy, CoordTy);       \
                                                                        \
  __attribute__((overloadable, always_inline)) DstTy                    \
  Func(image2d_array_depth_t image, CoordTy##4 coords) {                \
    float                                                               \
      data = HsailIntrin(image, coords.x, coords.y, coords.z);          \
    return data;                                                        \
}

DefLoadImage2DArrayDepth(read_imagef, __hsail_ldimagef_2dadepth_u32, float, int)

#endif // __OPENCL_C_VERSION__ >= 200
