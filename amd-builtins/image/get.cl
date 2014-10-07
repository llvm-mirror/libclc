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
// Image query built-ins

#if __OPENCL_C_VERSION__ >= 200
#define CLK_UNORM_INT24              0x10DF
// BRIG enum should match the one in \compiler\hsail-tools\libHSAIL\Brig_new.hpp
// TODO : We need to have a single file header with those enums shared across components
enum BrigImageChannelOrder {
    //.mnemo={ s/^BRIG_CHANNEL_ORDER_?//;lc }
    //.mnemo_token=EImageOrder
    //.mnemo_context=EImageOrderContext
    BRIG_CHANNEL_ORDER_A             = 0,
    BRIG_CHANNEL_ORDER_R             = 1,
    BRIG_CHANNEL_ORDER_RX            = 2,
    BRIG_CHANNEL_ORDER_RG            = 3,
    BRIG_CHANNEL_ORDER_RGX           = 4,
    BRIG_CHANNEL_ORDER_RA            = 5,
    BRIG_CHANNEL_ORDER_RGB           = 6,
    BRIG_CHANNEL_ORDER_RGBX          = 7,
    BRIG_CHANNEL_ORDER_RGBA          = 8,
    BRIG_CHANNEL_ORDER_BGRA          = 9,
    BRIG_CHANNEL_ORDER_ARGB          = 10,
    BRIG_CHANNEL_ORDER_ABGR          = 11,
    BRIG_CHANNEL_ORDER_SRGB          = 12,
    BRIG_CHANNEL_ORDER_SRGBX         = 13,
    BRIG_CHANNEL_ORDER_SRGBA         = 14,
    BRIG_CHANNEL_ORDER_SBGRA         = 15,
    BRIG_CHANNEL_ORDER_INTENSITY     = 16,
    BRIG_CHANNEL_ORDER_LUMINANCE     = 17,
    BRIG_CHANNEL_ORDER_DEPTH         = 18,
    BRIG_CHANNEL_ORDER_DEPTH_STENCIL = 19
};

enum BrigImageChannelType {
    //.mnemo={ s/^BRIG_CHANNEL_TYPE_//;lc }
    //.mnemo_token=EImageFormat
    BRIG_CHANNEL_TYPE_SNORM_INT8         = 0,
    BRIG_CHANNEL_TYPE_SNORM_INT16        = 1,
    BRIG_CHANNEL_TYPE_UNORM_INT8         = 2,
    BRIG_CHANNEL_TYPE_UNORM_INT16        = 3,
    BRIG_CHANNEL_TYPE_UNORM_INT24        = 4,
    BRIG_CHANNEL_TYPE_UNORM_SHORT_555    = 5,
    BRIG_CHANNEL_TYPE_UNORM_SHORT_565    = 6,
    BRIG_CHANNEL_TYPE_UNORM_SHORT_101010 = 7,
    BRIG_CHANNEL_TYPE_SIGNED_INT8        = 8,
    BRIG_CHANNEL_TYPE_SIGNED_INT16       = 9,
    BRIG_CHANNEL_TYPE_SIGNED_INT32       = 10,
    BRIG_CHANNEL_TYPE_UNSIGNED_INT8      = 11,
    BRIG_CHANNEL_TYPE_UNSIGNED_INT16     = 12,
    BRIG_CHANNEL_TYPE_UNSIGNED_INT32     = 13,
    BRIG_CHANNEL_TYPE_HALF_FLOAT         = 14,
    BRIG_CHANNEL_TYPE_FLOAT              = 15
};
#endif

// Hsail image query intrinsics
extern __attribute__((pure)) int __hsail_query_width_1d(image1d_t);
extern __attribute__((pure)) int __hsail_query_width_1db(image1d_buffer_t);
extern __attribute__((pure)) int __hsail_query_width_1da(image1d_array_t);
extern __attribute__((pure)) int __hsail_query_width_2d(image2d_t);
extern __attribute__((pure)) int __hsail_query_width_2da(image2d_array_t);
extern __attribute__((pure)) int __hsail_query_width_3d(image3d_t);

extern __attribute__((pure)) int __hsail_query_height_2d(image2d_t);
extern __attribute__((pure)) int __hsail_query_height_2da(image2d_array_t);
extern __attribute__((pure)) int __hsail_query_height_3d(image3d_t);

extern __attribute__((pure)) int __hsail_depth_3d(image3d_t);

extern __attribute__((pure)) int __hsail_query_format_1d(image1d_t);
extern __attribute__((pure)) int __hsail_query_format_1db(image1d_buffer_t);
extern __attribute__((pure)) int __hsail_query_format_1da(image1d_array_t);
extern __attribute__((pure)) int __hsail_query_format_2d(image2d_t);
extern __attribute__((pure)) int __hsail_query_format_2da(image2d_array_t);
extern __attribute__((pure)) int __hsail_query_format_3d(image3d_t);

extern __attribute__((pure)) int __hsail_query_order_1d(image1d_t);
extern __attribute__((pure)) int __hsail_query_order_1db(image1d_buffer_t);
extern __attribute__((pure)) int __hsail_query_order_1da(image1d_array_t);
extern __attribute__((pure)) int __hsail_query_order_2d(image2d_t);
extern __attribute__((pure)) int __hsail_query_order_2da(image2d_array_t);
extern __attribute__((pure)) int __hsail_query_order_3d(image3d_t);

extern __attribute__((pure)) uint __hsail_query_array_1da(image1d_array_t);
extern __attribute__((pure)) uint __hsail_query_array_2da(image2d_array_t);


#define DefQueryImage(Func,HsailIntrin,ImageTy,RetTy) \
__attribute__((overloadable, always_inline)) RetTy  \
Func(ImageTy image) { \
  return (RetTy)HsailIntrin(image);  \
}

#if __OPENCL_C_VERSION__ >= 200
#define DefQueryImageChOrder(Func,HsailIntrin,ImageTy,RetTy) \
__attribute__((overloadable, always_inline)) RetTy  \
Func(ImageTy image) { \
  uint Chorder = (RetTy)HsailIntrin(image);  \
  return (mapBRIGChOrderToOCLChOrder(Chorder)); \
}

#define DefQueryImageChType(Func,HsailIntrin,ImageTy,RetTy) \
__attribute__((overloadable, always_inline)) RetTy  \
Func(ImageTy image) { \
  uint Chtype = (RetTy)HsailIntrin(image);  \
  return (mapBRIGChTypeToOCLChType(Chtype)); \
}

static inline uint mapBRIGChOrderToOCLChOrder(uint BRIGChOrder) {
  uint chorder;
  switch (BRIGChOrder) {
    case BRIG_CHANNEL_ORDER_A: chorder = CLK_A; break;
    case BRIG_CHANNEL_ORDER_R: chorder = CLK_R; break;
    case BRIG_CHANNEL_ORDER_RX: chorder = CLK_Rx; break;
    case BRIG_CHANNEL_ORDER_RG: chorder = CLK_RG; break;
    case BRIG_CHANNEL_ORDER_RGX: chorder = CLK_RGx; break;
    case BRIG_CHANNEL_ORDER_RA: chorder = CLK_RA; break;
    case BRIG_CHANNEL_ORDER_RGB: chorder = CLK_RGB; break;
    case BRIG_CHANNEL_ORDER_RGBX: chorder = CLK_RGBx; break;
    case BRIG_CHANNEL_ORDER_RGBA: chorder = CLK_RGBA; break;
    case BRIG_CHANNEL_ORDER_BGRA: chorder = CLK_BGRA; break;
    case BRIG_CHANNEL_ORDER_ARGB: chorder = CLK_ARGB; break;
    case BRIG_CHANNEL_ORDER_SRGB: chorder = CLK_sRGB; break;
    case BRIG_CHANNEL_ORDER_SRGBX: chorder = CLK_sRGBx; break;
    case BRIG_CHANNEL_ORDER_SRGBA: chorder = CLK_sRGBA; break;
    case BRIG_CHANNEL_ORDER_SBGRA: chorder = CLK_sBGRA; break;
    case BRIG_CHANNEL_ORDER_INTENSITY: chorder = CLK_INTENSITY; break;
    case BRIG_CHANNEL_ORDER_LUMINANCE: chorder = CLK_LUMINANCE; break;
    case BRIG_CHANNEL_ORDER_DEPTH: chorder = CLK_DEPTH; break;
    case BRIG_CHANNEL_ORDER_DEPTH_STENCIL: chorder = CLK_DEPTH_STENCIL; break;
  }
  return chorder;
}

static inline uint mapBRIGChTypeToOCLChType(uint BRIGChType) {
  uint chtype;
  switch (BRIGChType) {
    case BRIG_CHANNEL_TYPE_SNORM_INT8: chtype = CLK_SNORM_INT8; break;
    case BRIG_CHANNEL_TYPE_SNORM_INT16: chtype = CLK_SNORM_INT16; break;
    case BRIG_CHANNEL_TYPE_UNORM_INT8: chtype = CLK_UNORM_INT8; break;
    case BRIG_CHANNEL_TYPE_UNORM_INT16: chtype = CLK_UNORM_INT16; break;
    case BRIG_CHANNEL_TYPE_UNORM_INT24: chtype = CLK_UNORM_INT24; break;
    case BRIG_CHANNEL_TYPE_UNORM_SHORT_555: chtype = CLK_UNORM_SHORT_555; break;
    case BRIG_CHANNEL_TYPE_UNORM_SHORT_565: chtype = CLK_UNORM_SHORT_565; break;
    // Todo: Need to change *_UNORM_SHORT_101010 to *_UNORM_INT_101010 once BRIG enum will change
    case BRIG_CHANNEL_TYPE_UNORM_SHORT_101010: chtype = CLK_UNORM_INT_101010; break;
    case BRIG_CHANNEL_TYPE_SIGNED_INT8: chtype = CLK_SIGNED_INT8; break;
    case BRIG_CHANNEL_TYPE_SIGNED_INT16: chtype = CLK_SIGNED_INT16; break;
    case BRIG_CHANNEL_TYPE_SIGNED_INT32: chtype = CLK_SIGNED_INT32; break;
    case BRIG_CHANNEL_TYPE_UNSIGNED_INT8: chtype = CLK_UNSIGNED_INT8; break;
    case BRIG_CHANNEL_TYPE_UNSIGNED_INT16: chtype = CLK_UNSIGNED_INT16; break;
    case BRIG_CHANNEL_TYPE_UNSIGNED_INT32: chtype = CLK_UNSIGNED_INT32; break;
    case BRIG_CHANNEL_TYPE_HALF_FLOAT: chtype = CLK_HALF_FLOAT; break;
    case BRIG_CHANNEL_TYPE_FLOAT: chtype = CLK_FLOAT; break;
  }
  return chtype;
}
#endif

DefQueryImage(get_image_width, __hsail_query_width_1d, image1d_t, int)
DefQueryImage(get_image_width, __hsail_query_width_1db, image1d_buffer_t, int)
DefQueryImage(get_image_width, __hsail_query_width_1da, image1d_array_t, int)
DefQueryImage(get_image_width, __hsail_query_width_2d, image2d_t, int)
DefQueryImage(get_image_width, __hsail_query_width_2da, image2d_array_t, int)
DefQueryImage(get_image_width, __hsail_query_width_3d, image3d_t, int)

DefQueryImage(get_image_height, __hsail_query_height_2d, image2d_t, int)
DefQueryImage(get_image_height, __hsail_query_height_2da, image2d_array_t, int)
DefQueryImage(get_image_height, __hsail_query_height_3d, image3d_t, int)

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) int
get_image_depth(image3d_t image) {
  return __hsail_depth_3d(image);
}

#if __OPENCL_C_VERSION__ >= 200
DefQueryImageChType(get_image_channel_data_type, __hsail_query_format_1d, image1d_t, int)
DefQueryImageChType(get_image_channel_data_type, __hsail_query_format_1db, image1d_buffer_t, int)
DefQueryImageChType(get_image_channel_data_type, __hsail_query_format_1da, image1d_array_t, int)
DefQueryImageChType(get_image_channel_data_type, __hsail_query_format_2d, image2d_t, int)
DefQueryImageChType(get_image_channel_data_type, __hsail_query_format_2da, image2d_array_t, int)
DefQueryImageChType(get_image_channel_data_type, __hsail_query_format_3d, image3d_t, int)

DefQueryImageChOrder(get_image_channel_order, __hsail_query_order_1d, image1d_t, int)
DefQueryImageChOrder(get_image_channel_order, __hsail_query_order_1db, image1d_buffer_t, int)
DefQueryImageChOrder(get_image_channel_order, __hsail_query_order_1da, image1d_array_t, int)
DefQueryImageChOrder(get_image_channel_order, __hsail_query_order_2d, image2d_t, int)
DefQueryImageChOrder(get_image_channel_order, __hsail_query_order_2da, image2d_array_t, int)
DefQueryImageChOrder(get_image_channel_order, __hsail_query_order_3d, image3d_t, int)

#else
DefQueryImage(get_image_channel_data_type, __hsail_query_format_1d, image1d_t, int)
DefQueryImage(get_image_channel_data_type, __hsail_query_format_1db, image1d_buffer_t, int)
DefQueryImage(get_image_channel_data_type, __hsail_query_format_1da, image1d_array_t, int)
DefQueryImage(get_image_channel_data_type, __hsail_query_format_2d, image2d_t, int)
DefQueryImage(get_image_channel_data_type, __hsail_query_format_2da, image2d_array_t, int)
DefQueryImage(get_image_channel_data_type, __hsail_query_format_3d, image3d_t, int)

DefQueryImage(get_image_channel_order, __hsail_query_order_1d, image1d_t, int)
DefQueryImage(get_image_channel_order, __hsail_query_order_1db, image1d_buffer_t, int)
DefQueryImage(get_image_channel_order, __hsail_query_order_1da, image1d_array_t, int)
DefQueryImage(get_image_channel_order, __hsail_query_order_2d, image2d_t, int)
DefQueryImage(get_image_channel_order, __hsail_query_order_2da, image2d_array_t, int)
DefQueryImage(get_image_channel_order, __hsail_query_order_3d, image3d_t, int)
#endif

__attribute__((overloadable, always_inline)) int2
get_image_dim(image2d_t image) {
  int2 dim;
  dim.x = get_image_width(image);
  dim.y = get_image_height(image);
  return dim;
}

__attribute__((overloadable, always_inline)) int2
get_image_dim(image2d_array_t image) {
  int2 dim;
  dim.x = get_image_width(image);
  dim.y = get_image_height(image);
  return dim;
}

__attribute__((overloadable, always_inline)) int4
get_image_dim(image3d_t image) {
  int4 dim;
  dim.x = get_image_width(image);
  dim.y = get_image_height(image);
  dim.z = get_image_depth(image);
  dim.w = 0;
  return dim;
}

DefQueryImage(get_image_array_size, __hsail_query_array_1da, image1d_array_t, size_t);
DefQueryImage(get_image_array_size, __hsail_query_array_2da, image2d_array_t, size_t);

#if __OPENCL_C_VERSION__ >= 200
// Image-2.0 query built-ins

// Hsail image query intrinsics
extern __attribute__((pure)) int __hsail_query_width_2ddepth(image2d_depth_t);
extern __attribute__((pure)) int __hsail_query_width_2dadepth(image2d_array_depth_t);

extern __attribute__((pure)) int __hsail_query_height_2ddepth(image2d_depth_t);
extern __attribute__((pure)) int __hsail_query_height_2dadepth(image2d_array_depth_t);

extern __attribute__((pure)) int __hsail_query_array_2dadepth(image2d_array_depth_t);

extern __attribute__((pure)) int __hsail_query_channelorder_2ddepth(image2d_depth_t);
extern __attribute__((pure)) int __hsail_query_channelorder_2dadepth(image2d_array_depth_t);

extern __attribute__((pure)) int __hsail_query_channeltype_2ddepth(image2d_depth_t);
extern __attribute__((pure)) int __hsail_query_channeltype_2dadepth(image2d_array_depth_t);

DefQueryImage(get_image_width, __hsail_query_width_2ddepth, image2d_depth_t, int)
DefQueryImage(get_image_width, __hsail_query_width_2dadepth, image2d_array_depth_t, int)

DefQueryImage(get_image_height, __hsail_query_height_2ddepth, image2d_depth_t, int)
DefQueryImage(get_image_height, __hsail_query_height_2dadepth, image2d_array_depth_t, int)

DefQueryImageChType(get_image_channel_data_type, __hsail_query_channeltype_2ddepth, image2d_depth_t, int)
DefQueryImageChType(get_image_channel_data_type, __hsail_query_channeltype_2dadepth, image2d_array_depth_t, int)

DefQueryImageChOrder(get_image_channel_order, __hsail_query_channelorder_2ddepth, image2d_depth_t, int)
DefQueryImageChOrder(get_image_channel_order, __hsail_query_channelorder_2dadepth, image2d_array_depth_t, int)


__attribute__((overloadable, always_inline)) int2
get_image_dim(image2d_depth_t image) {
  int2 dim;
  dim.x = get_image_width(image);
  dim.y = get_image_height(image);
  return dim;
}
__attribute__((overloadable, always_inline)) int2
get_image_dim(image2d_array_depth_t image) {
  int2 dim;
  dim.x = get_image_width(image);
  dim.y = get_image_height(image);
  return dim;
}

DefQueryImage(get_image_array_size, __hsail_query_array_2dadepth, image2d_array_depth_t, size_t)

#endif // __OPENCL_C_VERSION__ >= 200
