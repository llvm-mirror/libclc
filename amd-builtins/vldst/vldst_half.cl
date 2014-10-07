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


extern __attribute__((pure)) float __cvt_f16_to_f32(ushort);

__attribute__((always_inline)) static float
vldhp(size_t i, const half *p)
{
    ushort h = *(const short *)(p + i);
    return __cvt_f16_to_f32(h);
}
extern __attribute__((overloadable, weak, alias("vldhp"))) float  vload_half(size_t, const half *);
extern __attribute__((overloadable, weak, alias("vldhp"))) float vloada_half(size_t, const half *);



extern __attribute__((pure)) float __cvt_f16_to_f32(ushort);

__attribute__((always_inline)) static float
vldhc(size_t i, const __constant half *p)
{
    ushort h = *(const __constant short *)(p + i);
    return __cvt_f16_to_f32(h);
}
extern __attribute__((overloadable, weak, alias("vldhc"))) float  vload_half(size_t, const __constant half *);
extern __attribute__((overloadable, weak, alias("vldhc"))) float vloada_half(size_t, const __constant half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float __cvt_f16_to_f32(ushort);

__attribute__((always_inline)) static float
vldhg(size_t i, const __global half *p)
{
    ushort h = *(const __global short *)(p + i);
    return __cvt_f16_to_f32(h);
}
extern __attribute__((overloadable, weak, alias("vldhg"))) float  vload_half(size_t, const __global half *);
extern __attribute__((overloadable, weak, alias("vldhg"))) float vloada_half(size_t, const __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float __cvt_f16_to_f32(ushort);

__attribute__((always_inline)) static float
vldhl(size_t i, const __local half *p)
{
    ushort h = *(const __local short *)(p + i);
    return __cvt_f16_to_f32(h);
}
extern __attribute__((overloadable, weak, alias("vldhl"))) float  vload_half(size_t, const __local half *);
extern __attribute__((overloadable, weak, alias("vldhl"))) float vloada_half(size_t, const __local half *);
#endif


extern __attribute__((pure)) float2 __cvt_2f16_to_2f32(ushort2);

__attribute__((overloadable, always_inline, weak)) float2
vload_half2(size_t i, const half *p)
{
    return __cvt_2f16_to_2f32(vload2(i, (const ushort *)p));
}



extern __attribute__((pure)) float2 __cvt_2f16_to_2f32(ushort2);

__attribute__((overloadable, always_inline, weak)) float2
vload_half2(size_t i, const __constant half *p)
{
    return __cvt_2f16_to_2f32(vload2(i, (const __constant ushort *)p));
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float2 __cvt_2f16_to_2f32(ushort2);

__attribute__((overloadable, always_inline, weak)) float2
vload_half2(size_t i, const __global half *p)
{
    return __cvt_2f16_to_2f32(vload2(i, (const __global ushort *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float2 __cvt_2f16_to_2f32(ushort2);

__attribute__((overloadable, always_inline, weak)) float2
vload_half2(size_t i, const __local half *p)
{
    return __cvt_2f16_to_2f32(vload2(i, (const __local ushort *)p));
}
#endif


extern __attribute__((pure)) float3 __cvt_3f16_to_3f32(ushort3);

__attribute__((overloadable, always_inline, weak)) float3
vload_half3(size_t i, const half *p)
{
    return __cvt_3f16_to_3f32(vload3(i, (const ushort *)p));
}



extern __attribute__((pure)) float3 __cvt_3f16_to_3f32(ushort3);

__attribute__((overloadable, always_inline, weak)) float3
vload_half3(size_t i, const __constant half *p)
{
    return __cvt_3f16_to_3f32(vload3(i, (const __constant ushort *)p));
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float3 __cvt_3f16_to_3f32(ushort3);

__attribute__((overloadable, always_inline, weak)) float3
vload_half3(size_t i, const __global half *p)
{
    return __cvt_3f16_to_3f32(vload3(i, (const __global ushort *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float3 __cvt_3f16_to_3f32(ushort3);

__attribute__((overloadable, always_inline, weak)) float3
vload_half3(size_t i, const __local half *p)
{
    return __cvt_3f16_to_3f32(vload3(i, (const __local ushort *)p));
}
#endif


extern __attribute__((pure)) float4 __cvt_4f16_to_4f32(ushort4);

__attribute__((overloadable, always_inline, weak)) float4
vload_half4(size_t i, const half *p)
{
    return __cvt_4f16_to_4f32(vload4(i, (const ushort *)p));
}



extern __attribute__((pure)) float4 __cvt_4f16_to_4f32(ushort4);

__attribute__((overloadable, always_inline, weak)) float4
vload_half4(size_t i, const __constant half *p)
{
    return __cvt_4f16_to_4f32(vload4(i, (const __constant ushort *)p));
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float4 __cvt_4f16_to_4f32(ushort4);

__attribute__((overloadable, always_inline, weak)) float4
vload_half4(size_t i, const __global half *p)
{
    return __cvt_4f16_to_4f32(vload4(i, (const __global ushort *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float4 __cvt_4f16_to_4f32(ushort4);

__attribute__((overloadable, always_inline, weak)) float4
vload_half4(size_t i, const __local half *p)
{
    return __cvt_4f16_to_4f32(vload4(i, (const __local ushort *)p));
}
#endif


extern __attribute__((pure)) float8 __cvt_8f16_to_8f32(ushort8);

__attribute__((overloadable, always_inline, weak)) float8
vload_half8(size_t i, const half *p)
{
    return __cvt_8f16_to_8f32(vload8(i, (const ushort *)p));
}



extern __attribute__((pure)) float8 __cvt_8f16_to_8f32(ushort8);

__attribute__((overloadable, always_inline, weak)) float8
vload_half8(size_t i, const __constant half *p)
{
    return __cvt_8f16_to_8f32(vload8(i, (const __constant ushort *)p));
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float8 __cvt_8f16_to_8f32(ushort8);

__attribute__((overloadable, always_inline, weak)) float8
vload_half8(size_t i, const __global half *p)
{
    return __cvt_8f16_to_8f32(vload8(i, (const __global ushort *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float8 __cvt_8f16_to_8f32(ushort8);

__attribute__((overloadable, always_inline, weak)) float8
vload_half8(size_t i, const __local half *p)
{
    return __cvt_8f16_to_8f32(vload8(i, (const __local ushort *)p));
}
#endif


extern __attribute__((pure)) float16 __cvt_16f16_to_16f32(ushort16);

__attribute__((overloadable, always_inline, weak)) float16
vload_half16(size_t i, const half *p)
{
    return __cvt_16f16_to_16f32(vload16(i, (const ushort *)p));
}



extern __attribute__((pure)) float16 __cvt_16f16_to_16f32(ushort16);

__attribute__((overloadable, always_inline, weak)) float16
vload_half16(size_t i, const __constant half *p)
{
    return __cvt_16f16_to_16f32(vload16(i, (const __constant ushort *)p));
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float16 __cvt_16f16_to_16f32(ushort16);

__attribute__((overloadable, always_inline, weak)) float16
vload_half16(size_t i, const __global half *p)
{
    return __cvt_16f16_to_16f32(vload16(i, (const __global ushort *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float16 __cvt_16f16_to_16f32(ushort16);

__attribute__((overloadable, always_inline, weak)) float16
vload_half16(size_t i, const __local half *p)
{
    return __cvt_16f16_to_16f32(vload16(i, (const __local ushort *)p));
}
#endif


extern __attribute__((pure)) float2 __cvt_2f16_to_2f32(ushort2);

__attribute__((overloadable, always_inline, weak)) float2
vloada_half2(size_t i, const half *p)
{

    return __cvt_2f16_to_2f32(*(const ushort2 *)(p + i * 2));

}



extern __attribute__((pure)) float2 __cvt_2f16_to_2f32(ushort2);

__attribute__((overloadable, always_inline, weak)) float2
vloada_half2(size_t i, const __constant half *p)
{

    return __cvt_2f16_to_2f32(*(const __constant ushort2 *)(p + i * 2));

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float2 __cvt_2f16_to_2f32(ushort2);

__attribute__((overloadable, always_inline, weak)) float2
vloada_half2(size_t i, const __global half *p)
{

    return __cvt_2f16_to_2f32(*(const __global ushort2 *)(p + i * 2));

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float2 __cvt_2f16_to_2f32(ushort2);

__attribute__((overloadable, always_inline, weak)) float2
vloada_half2(size_t i, const __local half *p)
{

    return __cvt_2f16_to_2f32(*(const __local ushort2 *)(p + i * 2));

}
#endif


extern __attribute__((pure)) float3 __cvt_3f16_to_3f32(ushort3);

__attribute__((overloadable, always_inline, weak)) float3
vloada_half3(size_t i, const half *p)
{

    ushort4 h = *(const ushort4 *)(p + i * 4);
    return __cvt_3f16_to_3f32(h.s012);

}



extern __attribute__((pure)) float3 __cvt_3f16_to_3f32(ushort3);

__attribute__((overloadable, always_inline, weak)) float3
vloada_half3(size_t i, const __constant half *p)
{

    ushort4 h = *(const __constant ushort4 *)(p + i * 4);
    return __cvt_3f16_to_3f32(h.s012);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float3 __cvt_3f16_to_3f32(ushort3);

__attribute__((overloadable, always_inline, weak)) float3
vloada_half3(size_t i, const __global half *p)
{

    ushort4 h = *(const __global ushort4 *)(p + i * 4);
    return __cvt_3f16_to_3f32(h.s012);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float3 __cvt_3f16_to_3f32(ushort3);

__attribute__((overloadable, always_inline, weak)) float3
vloada_half3(size_t i, const __local half *p)
{

    ushort4 h = *(const __local ushort4 *)(p + i * 4);
    return __cvt_3f16_to_3f32(h.s012);

}
#endif


extern __attribute__((pure)) float4 __cvt_4f16_to_4f32(ushort4);

__attribute__((overloadable, always_inline, weak)) float4
vloada_half4(size_t i, const half *p)
{

    return __cvt_4f16_to_4f32(*(const ushort4 *)(p + i * 4));

}



extern __attribute__((pure)) float4 __cvt_4f16_to_4f32(ushort4);

__attribute__((overloadable, always_inline, weak)) float4
vloada_half4(size_t i, const __constant half *p)
{

    return __cvt_4f16_to_4f32(*(const __constant ushort4 *)(p + i * 4));

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float4 __cvt_4f16_to_4f32(ushort4);

__attribute__((overloadable, always_inline, weak)) float4
vloada_half4(size_t i, const __global half *p)
{

    return __cvt_4f16_to_4f32(*(const __global ushort4 *)(p + i * 4));

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float4 __cvt_4f16_to_4f32(ushort4);

__attribute__((overloadable, always_inline, weak)) float4
vloada_half4(size_t i, const __local half *p)
{

    return __cvt_4f16_to_4f32(*(const __local ushort4 *)(p + i * 4));

}
#endif


extern __attribute__((pure)) float8 __cvt_8f16_to_8f32(ushort8);

__attribute__((overloadable, always_inline, weak)) float8
vloada_half8(size_t i, const half *p)
{

    return __cvt_8f16_to_8f32(*(const ushort8 *)(p + i * 8));

}



extern __attribute__((pure)) float8 __cvt_8f16_to_8f32(ushort8);

__attribute__((overloadable, always_inline, weak)) float8
vloada_half8(size_t i, const __constant half *p)
{

    return __cvt_8f16_to_8f32(*(const __constant ushort8 *)(p + i * 8));

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float8 __cvt_8f16_to_8f32(ushort8);

__attribute__((overloadable, always_inline, weak)) float8
vloada_half8(size_t i, const __global half *p)
{

    return __cvt_8f16_to_8f32(*(const __global ushort8 *)(p + i * 8));

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float8 __cvt_8f16_to_8f32(ushort8);

__attribute__((overloadable, always_inline, weak)) float8
vloada_half8(size_t i, const __local half *p)
{

    return __cvt_8f16_to_8f32(*(const __local ushort8 *)(p + i * 8));

}
#endif


extern __attribute__((pure)) float16 __cvt_16f16_to_16f32(ushort16);

__attribute__((overloadable, always_inline, weak)) float16
vloada_half16(size_t i, const half *p)
{

    return __cvt_16f16_to_16f32(*(const ushort16 *)(p + i * 16));

}



extern __attribute__((pure)) float16 __cvt_16f16_to_16f32(ushort16);

__attribute__((overloadable, always_inline, weak)) float16
vloada_half16(size_t i, const __constant half *p)
{

    return __cvt_16f16_to_16f32(*(const __constant ushort16 *)(p + i * 16));

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float16 __cvt_16f16_to_16f32(ushort16);

__attribute__((overloadable, always_inline, weak)) float16
vloada_half16(size_t i, const __global half *p)
{

    return __cvt_16f16_to_16f32(*(const __global ushort16 *)(p + i * 16));

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) float16 __cvt_16f16_to_16f32(ushort16);

__attribute__((overloadable, always_inline, weak)) float16
vloada_half16(size_t i, const __local half *p)
{

    return __cvt_16f16_to_16f32(*(const __local ushort16 *)(p + i * 16));

}
#endif


extern __attribute__((pure)) ushort __cvt_f32_to_f16_cur(float);

__attribute__((always_inline)) static void
vsthpf32c(float v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f32_to_f16_cur(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf32c")))  void vstore_half(float, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf32c"))) void vstorea_half(float, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_cur(float);

__attribute__((always_inline)) static void
vsthgf32c(float v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f32_to_f16_cur(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf32c")))  void vstore_half(float, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf32c"))) void vstorea_half(float, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_cur(float);

__attribute__((always_inline)) static void
vsthlf32c(float v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f32_to_f16_cur(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf32c")))  void vstore_half(float, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf32c"))) void vstorea_half(float, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f32_to_f16_rte(float);

__attribute__((always_inline)) static void
vsthpf32e(float v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f32_to_f16_rte(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf32e")))  void vstore_half_rte(float, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf32e"))) void vstorea_half_rte(float, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_rte(float);

__attribute__((always_inline)) static void
vsthgf32e(float v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f32_to_f16_rte(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf32e")))  void vstore_half_rte(float, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf32e"))) void vstorea_half_rte(float, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_rte(float);

__attribute__((always_inline)) static void
vsthlf32e(float v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f32_to_f16_rte(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf32e")))  void vstore_half_rte(float, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf32e"))) void vstorea_half_rte(float, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtp(float);

__attribute__((always_inline)) static void
vsthpf32p(float v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f32_to_f16_rtp(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf32p")))  void vstore_half_rtp(float, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf32p"))) void vstorea_half_rtp(float, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtp(float);

__attribute__((always_inline)) static void
vsthgf32p(float v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f32_to_f16_rtp(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf32p")))  void vstore_half_rtp(float, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf32p"))) void vstorea_half_rtp(float, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtp(float);

__attribute__((always_inline)) static void
vsthlf32p(float v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f32_to_f16_rtp(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf32p")))  void vstore_half_rtp(float, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf32p"))) void vstorea_half_rtp(float, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtn(float);

__attribute__((always_inline)) static void
vsthpf32n(float v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f32_to_f16_rtn(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf32n")))  void vstore_half_rtn(float, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf32n"))) void vstorea_half_rtn(float, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtn(float);

__attribute__((always_inline)) static void
vsthgf32n(float v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f32_to_f16_rtn(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf32n")))  void vstore_half_rtn(float, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf32n"))) void vstorea_half_rtn(float, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtn(float);

__attribute__((always_inline)) static void
vsthlf32n(float v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f32_to_f16_rtn(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf32n")))  void vstore_half_rtn(float, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf32n"))) void vstorea_half_rtn(float, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtz(float);

__attribute__((always_inline)) static void
vsthpf32z(float v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f32_to_f16_rtz(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf32z")))  void vstore_half_rtz(float, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf32z"))) void vstorea_half_rtz(float, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtz(float);

__attribute__((always_inline)) static void
vsthgf32z(float v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f32_to_f16_rtz(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf32z")))  void vstore_half_rtz(float, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf32z"))) void vstorea_half_rtz(float, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f32_to_f16_rtz(float);

__attribute__((always_inline)) static void
vsthlf32z(float v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f32_to_f16_rtz(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf32z")))  void vstore_half_rtz(float, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf32z"))) void vstorea_half_rtz(float, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f64_to_f16_cur(double);

__attribute__((always_inline)) static void
vsthpf64c(double v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f64_to_f16_cur(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf64c")))  void vstore_half(double, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf64c"))) void vstorea_half(double, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_cur(double);

__attribute__((always_inline)) static void
vsthgf64c(double v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f64_to_f16_cur(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf64c")))  void vstore_half(double, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf64c"))) void vstorea_half(double, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_cur(double);

__attribute__((always_inline)) static void
vsthlf64c(double v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f64_to_f16_cur(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf64c")))  void vstore_half(double, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf64c"))) void vstorea_half(double, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f64_to_f16_rte(double);

__attribute__((always_inline)) static void
vsthpf64e(double v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f64_to_f16_rte(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf64e")))  void vstore_half_rte(double, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf64e"))) void vstorea_half_rte(double, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_rte(double);

__attribute__((always_inline)) static void
vsthgf64e(double v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f64_to_f16_rte(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf64e")))  void vstore_half_rte(double, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf64e"))) void vstorea_half_rte(double, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_rte(double);

__attribute__((always_inline)) static void
vsthlf64e(double v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f64_to_f16_rte(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf64e")))  void vstore_half_rte(double, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf64e"))) void vstorea_half_rte(double, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtp(double);

__attribute__((always_inline)) static void
vsthpf64p(double v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f64_to_f16_rtp(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf64p")))  void vstore_half_rtp(double, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf64p"))) void vstorea_half_rtp(double, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtp(double);

__attribute__((always_inline)) static void
vsthgf64p(double v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f64_to_f16_rtp(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf64p")))  void vstore_half_rtp(double, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf64p"))) void vstorea_half_rtp(double, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtp(double);

__attribute__((always_inline)) static void
vsthlf64p(double v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f64_to_f16_rtp(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf64p")))  void vstore_half_rtp(double, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf64p"))) void vstorea_half_rtp(double, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtn(double);

__attribute__((always_inline)) static void
vsthpf64n(double v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f64_to_f16_rtn(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf64n")))  void vstore_half_rtn(double, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf64n"))) void vstorea_half_rtn(double, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtn(double);

__attribute__((always_inline)) static void
vsthgf64n(double v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f64_to_f16_rtn(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf64n")))  void vstore_half_rtn(double, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf64n"))) void vstorea_half_rtn(double, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtn(double);

__attribute__((always_inline)) static void
vsthlf64n(double v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f64_to_f16_rtn(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf64n")))  void vstore_half_rtn(double, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf64n"))) void vstorea_half_rtn(double, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtz(double);

__attribute__((always_inline)) static void
vsthpf64z(double v, size_t i, half *p)
{
    *(ushort *)(p + i) = __cvt_f64_to_f16_rtz(v);
}
extern __attribute__((overloadable, weak, alias("vsthpf64z")))  void vstore_half_rtz(double, size_t, half *);
extern __attribute__((overloadable, weak, alias("vsthpf64z"))) void vstorea_half_rtz(double, size_t, half *);


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtz(double);

__attribute__((always_inline)) static void
vsthgf64z(double v, size_t i, __global half *p)
{
    *(__global ushort *)(p + i) = __cvt_f64_to_f16_rtz(v);
}
extern __attribute__((overloadable, weak, alias("vsthgf64z")))  void vstore_half_rtz(double, size_t, __global half *);
extern __attribute__((overloadable, weak, alias("vsthgf64z"))) void vstorea_half_rtz(double, size_t, __global half *);
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort __cvt_f64_to_f16_rtz(double);

__attribute__((always_inline)) static void
vsthlf64z(double v, size_t i, __local half *p)
{
    *(__local ushort *)(p + i) = __cvt_f64_to_f16_rtz(v);
}
extern __attribute__((overloadable, weak, alias("vsthlf64z")))  void vstore_half_rtz(double, size_t, __local half *);
extern __attribute__((overloadable, weak, alias("vsthlf64z"))) void vstorea_half_rtz(double, size_t, __local half *);
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_cur(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2(float2 v, size_t i, half *p)
{
    vstore2(__cvt_2f32_to_2f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_cur(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2(float2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f32_to_2f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_cur(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2(float2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f32_to_2f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rte(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rte(float2 v, size_t i, half *p)
{
    vstore2(__cvt_2f32_to_2f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rte(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rte(float2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f32_to_2f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rte(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rte(float2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f32_to_2f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtp(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtp(float2 v, size_t i, half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtp(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtp(float2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtp(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtp(float2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtn(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtn(float2 v, size_t i, half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtn(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtn(float2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtn(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtn(float2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtz(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtz(float2 v, size_t i, half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtz(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtz(float2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtz(float2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtz(float2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f32_to_2f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_cur(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3(float3 v, size_t i, half *p)
{
    vstore3(__cvt_3f32_to_3f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_cur(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3(float3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f32_to_3f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_cur(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3(float3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f32_to_3f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rte(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rte(float3 v, size_t i, half *p)
{
    vstore3(__cvt_3f32_to_3f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rte(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rte(float3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f32_to_3f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rte(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rte(float3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f32_to_3f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtp(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtp(float3 v, size_t i, half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtp(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtp(float3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtp(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtp(float3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtn(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtn(float3 v, size_t i, half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtn(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtn(float3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtn(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtn(float3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtz(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtz(float3 v, size_t i, half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtz(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtz(float3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtz(float3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtz(float3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f32_to_3f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_cur(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4(float4 v, size_t i, half *p)
{
    vstore4(__cvt_4f32_to_4f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_cur(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4(float4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f32_to_4f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_cur(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4(float4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f32_to_4f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rte(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rte(float4 v, size_t i, half *p)
{
    vstore4(__cvt_4f32_to_4f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rte(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rte(float4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f32_to_4f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rte(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rte(float4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f32_to_4f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtp(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtp(float4 v, size_t i, half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtp(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtp(float4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtp(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtp(float4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtn(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtn(float4 v, size_t i, half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtn(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtn(float4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtn(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtn(float4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtz(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtz(float4 v, size_t i, half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtz(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtz(float4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtz(float4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtz(float4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f32_to_4f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_cur(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8(float8 v, size_t i, half *p)
{
    vstore8(__cvt_8f32_to_8f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_cur(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8(float8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f32_to_8f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_cur(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8(float8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f32_to_8f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rte(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rte(float8 v, size_t i, half *p)
{
    vstore8(__cvt_8f32_to_8f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rte(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rte(float8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f32_to_8f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rte(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rte(float8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f32_to_8f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtp(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtp(float8 v, size_t i, half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtp(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtp(float8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtp(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtp(float8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtn(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtn(float8 v, size_t i, half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtn(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtn(float8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtn(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtn(float8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtz(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtz(float8 v, size_t i, half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtz(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtz(float8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtz(float8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtz(float8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f32_to_8f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_cur(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16(float16 v, size_t i, half *p)
{
    vstore16(__cvt_16f32_to_16f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_cur(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16(float16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f32_to_16f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_cur(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16(float16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f32_to_16f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rte(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rte(float16 v, size_t i, half *p)
{
    vstore16(__cvt_16f32_to_16f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rte(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rte(float16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f32_to_16f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rte(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rte(float16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f32_to_16f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtp(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtp(float16 v, size_t i, half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtp(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtp(float16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtp(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtp(float16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtn(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtn(float16 v, size_t i, half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtn(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtn(float16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtn(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtn(float16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtz(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtz(float16 v, size_t i, half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtz(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtz(float16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtz(float16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtz(float16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f32_to_16f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_cur(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2(double2 v, size_t i, half *p)
{
    vstore2(__cvt_2f64_to_2f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_cur(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2(double2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f64_to_2f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_cur(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2(double2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f64_to_2f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rte(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rte(double2 v, size_t i, half *p)
{
    vstore2(__cvt_2f64_to_2f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rte(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rte(double2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f64_to_2f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rte(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rte(double2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f64_to_2f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtp(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtp(double2 v, size_t i, half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtp(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtp(double2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtp(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtp(double2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtn(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtn(double2 v, size_t i, half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtn(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtn(double2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtn(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtn(double2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtz(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtz(double2 v, size_t i, half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtz(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtz(double2 v, size_t i, __global half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtz(double2);

__attribute__((overloadable, always_inline, weak)) void
vstore_half2_rtz(double2 v, size_t i, __local half *p)
{
    vstore2(__cvt_2f64_to_2f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_cur(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3(double3 v, size_t i, half *p)
{
    vstore3(__cvt_3f64_to_3f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_cur(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3(double3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f64_to_3f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_cur(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3(double3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f64_to_3f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rte(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rte(double3 v, size_t i, half *p)
{
    vstore3(__cvt_3f64_to_3f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rte(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rte(double3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f64_to_3f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rte(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rte(double3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f64_to_3f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtp(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtp(double3 v, size_t i, half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtp(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtp(double3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtp(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtp(double3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtn(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtn(double3 v, size_t i, half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtn(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtn(double3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtn(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtn(double3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtz(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtz(double3 v, size_t i, half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtz(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtz(double3 v, size_t i, __global half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtz(double3);

__attribute__((overloadable, always_inline, weak)) void
vstore_half3_rtz(double3 v, size_t i, __local half *p)
{
    vstore3(__cvt_3f64_to_3f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_cur(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4(double4 v, size_t i, half *p)
{
    vstore4(__cvt_4f64_to_4f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_cur(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4(double4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f64_to_4f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_cur(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4(double4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f64_to_4f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rte(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rte(double4 v, size_t i, half *p)
{
    vstore4(__cvt_4f64_to_4f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rte(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rte(double4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f64_to_4f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rte(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rte(double4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f64_to_4f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtp(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtp(double4 v, size_t i, half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtp(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtp(double4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtp(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtp(double4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtn(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtn(double4 v, size_t i, half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtn(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtn(double4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtn(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtn(double4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtz(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtz(double4 v, size_t i, half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtz(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtz(double4 v, size_t i, __global half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtz(double4);

__attribute__((overloadable, always_inline, weak)) void
vstore_half4_rtz(double4 v, size_t i, __local half *p)
{
    vstore4(__cvt_4f64_to_4f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_cur(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8(double8 v, size_t i, half *p)
{
    vstore8(__cvt_8f64_to_8f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_cur(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8(double8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f64_to_8f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_cur(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8(double8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f64_to_8f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rte(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rte(double8 v, size_t i, half *p)
{
    vstore8(__cvt_8f64_to_8f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rte(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rte(double8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f64_to_8f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rte(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rte(double8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f64_to_8f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtp(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtp(double8 v, size_t i, half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtp(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtp(double8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtp(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtp(double8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtn(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtn(double8 v, size_t i, half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtn(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtn(double8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtn(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtn(double8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtz(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtz(double8 v, size_t i, half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtz(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtz(double8 v, size_t i, __global half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtz(double8);

__attribute__((overloadable, always_inline, weak)) void
vstore_half8_rtz(double8 v, size_t i, __local half *p)
{
    vstore8(__cvt_8f64_to_8f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_cur(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16(double16 v, size_t i, half *p)
{
    vstore16(__cvt_16f64_to_16f16_cur(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_cur(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16(double16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f64_to_16f16_cur(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_cur(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16(double16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f64_to_16f16_cur(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rte(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rte(double16 v, size_t i, half *p)
{
    vstore16(__cvt_16f64_to_16f16_rte(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rte(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rte(double16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f64_to_16f16_rte(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rte(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rte(double16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f64_to_16f16_rte(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtp(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtp(double16 v, size_t i, half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtp(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtp(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtp(double16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtp(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtp(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtp(double16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtp(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtn(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtn(double16 v, size_t i, half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtn(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtn(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtn(double16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtn(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtn(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtn(double16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtn(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtz(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtz(double16 v, size_t i, half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtz(v), i, (ushort *)p);
}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtz(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtz(double16 v, size_t i, __global half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtz(v), i, (__global ushort *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtz(double16);

__attribute__((overloadable, always_inline, weak)) void
vstore_half16_rtz(double16 v, size_t i, __local half *p)
{
    vstore16(__cvt_16f64_to_16f16_rtz(v), i, (__local ushort *)p);
}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_cur(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2(float2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_cur(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_cur(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2(float2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_cur(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_cur(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2(float2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_cur(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rte(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rte(float2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rte(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rte(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rte(float2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rte(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rte(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rte(float2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rte(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtp(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtp(float2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtp(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtp(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtp(float2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtp(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtp(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtp(float2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtp(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtn(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtn(float2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtn(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtn(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtn(float2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtn(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtn(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtn(float2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtn(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtz(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtz(float2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtz(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtz(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtz(float2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtz(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f32_to_2f16_rtz(float2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtz(float2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f32_to_2f16_rtz(v);

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_cur(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3(float3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_cur(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_cur(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3(float3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_cur(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_cur(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3(float3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_cur(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rte(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rte(float3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rte(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rte(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rte(float3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rte(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rte(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rte(float3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rte(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtp(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtp(float3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtp(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtp(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtp(float3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtp(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtp(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtp(float3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtp(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtn(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtn(float3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtn(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtn(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtn(float3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtn(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtn(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtn(float3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtn(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtz(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtz(float3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtz(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtz(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtz(float3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtz(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f32_to_3f16_rtz(float3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtz(float3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f32_to_3f16_rtz(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_cur(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4(float4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_cur(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_cur(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4(float4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_cur(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_cur(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4(float4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_cur(v);

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rte(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rte(float4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rte(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rte(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rte(float4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rte(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rte(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rte(float4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rte(v);

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtp(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtp(float4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtp(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtp(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtp(float4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtp(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtp(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtp(float4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtp(v);

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtn(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtn(float4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtn(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtn(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtn(float4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtn(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtn(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtn(float4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtn(v);

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtz(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtz(float4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtz(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtz(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtz(float4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtz(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f32_to_4f16_rtz(float4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtz(float4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f32_to_4f16_rtz(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_cur(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8(float8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_cur(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_cur(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8(float8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_cur(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_cur(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8(float8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_cur(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rte(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rte(float8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rte(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rte(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rte(float8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rte(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rte(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rte(float8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rte(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtp(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtp(float8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtp(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtp(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtp(float8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtp(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtp(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtp(float8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtp(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtn(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtn(float8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtn(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtn(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtn(float8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtn(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtn(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtn(float8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtn(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtz(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtz(float8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtz(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtz(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtz(float8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtz(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f32_to_8f16_rtz(float8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtz(float8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f32_to_8f16_rtz(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_cur(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16(float16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_cur(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_cur(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16(float16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_cur(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_cur(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16(float16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_cur(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rte(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rte(float16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rte(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rte(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rte(float16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rte(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rte(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rte(float16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rte(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtp(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtp(float16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtp(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtp(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtp(float16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtp(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtp(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtp(float16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtp(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtn(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtn(float16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtn(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtn(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtn(float16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtn(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtn(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtn(float16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtn(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtz(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtz(float16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtz(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtz(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtz(float16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtz(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f32_to_16f16_rtz(float16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtz(float16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f32_to_16f16_rtz(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_cur(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2(double2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_cur(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_cur(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2(double2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_cur(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_cur(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2(double2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_cur(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rte(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rte(double2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rte(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rte(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rte(double2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rte(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rte(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rte(double2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rte(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtp(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtp(double2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtp(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtp(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtp(double2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtp(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtp(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtp(double2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtp(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtn(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtn(double2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtn(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtn(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtn(double2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtn(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtn(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtn(double2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtn(v);

}
#endif


extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtz(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtz(double2 v, size_t i, half *p)
{

    *(ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtz(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtz(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtz(double2 v, size_t i, __global half *p)
{

    *(__global ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtz(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort2 __cvt_2f64_to_2f16_rtz(double2);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half2_rtz(double2 v, size_t i, __local half *p)
{

    *(__local ushort2 *)(p + i * 2) = __cvt_2f64_to_2f16_rtz(v);

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_cur(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3(double3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_cur(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_cur(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3(double3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_cur(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_cur(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3(double3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_cur(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rte(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rte(double3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rte(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rte(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rte(double3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rte(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rte(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rte(double3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rte(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtp(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtp(double3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtp(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtp(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtp(double3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtp(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtp(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtp(double3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtp(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtn(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtn(double3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtn(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtn(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtn(double3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtn(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtn(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtn(double3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtn(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtz(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtz(double3 v, size_t i, half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtz(v);
    *(ushort4 *)(p + i * 4) = h;

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtz(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtz(double3 v, size_t i, __global half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtz(v);
    *(__global ushort4 *)(p + i * 4) = h;

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort3 __cvt_3f64_to_3f16_rtz(double3);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half3_rtz(double3 v, size_t i, __local half *p)
{

    ushort4 h;
    h.s012 = __cvt_3f64_to_3f16_rtz(v);
    *(__local ushort4 *)(p + i * 4) = h;

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_cur(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4(double4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_cur(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_cur(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4(double4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_cur(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_cur(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4(double4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_cur(v);

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rte(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rte(double4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rte(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rte(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rte(double4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rte(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rte(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rte(double4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rte(v);

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtp(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtp(double4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtp(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtp(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtp(double4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtp(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtp(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtp(double4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtp(v);

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtn(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtn(double4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtn(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtn(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtn(double4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtn(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtn(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtn(double4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtn(v);

}
#endif


extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtz(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtz(double4 v, size_t i, half *p)
{

    *(ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtz(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtz(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtz(double4 v, size_t i, __global half *p)
{

    *(__global ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtz(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort4 __cvt_4f64_to_4f16_rtz(double4);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half4_rtz(double4 v, size_t i, __local half *p)
{

    *(__local ushort4 *)(p + i * 4) = __cvt_4f64_to_4f16_rtz(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_cur(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8(double8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_cur(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_cur(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8(double8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_cur(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_cur(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8(double8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_cur(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rte(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rte(double8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rte(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rte(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rte(double8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rte(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rte(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rte(double8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rte(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtp(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtp(double8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtp(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtp(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtp(double8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtp(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtp(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtp(double8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtp(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtn(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtn(double8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtn(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtn(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtn(double8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtn(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtn(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtn(double8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtn(v);

}
#endif


extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtz(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtz(double8 v, size_t i, half *p)
{

    *(ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtz(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtz(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtz(double8 v, size_t i, __global half *p)
{

    *(__global ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtz(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort8 __cvt_8f64_to_8f16_rtz(double8);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half8_rtz(double8 v, size_t i, __local half *p)
{

    *(__local ushort8 *)(p + i * 8) = __cvt_8f64_to_8f16_rtz(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_cur(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16(double16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_cur(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_cur(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16(double16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_cur(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_cur(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16(double16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_cur(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rte(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rte(double16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rte(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rte(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rte(double16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rte(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rte(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rte(double16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rte(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtp(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtp(double16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtp(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtp(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtp(double16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtp(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtp(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtp(double16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtp(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtn(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtn(double16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtn(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtn(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtn(double16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtn(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtn(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtn(double16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtn(v);

}
#endif


extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtz(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtz(double16 v, size_t i, half *p)
{

    *(ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtz(v);

}


#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtz(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtz(double16 v, size_t i, __global half *p)
{

    *(__global ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtz(v);

}
#endif

#if __OPENCL_C_VERSION__ < 200
extern __attribute__((pure)) ushort16 __cvt_16f64_to_16f16_rtz(double16);

__attribute__((overloadable, always_inline, weak)) void
vstorea_half16_rtz(double16 v, size_t i, __local half *p)
{

    *(__local ushort16 *)(p + i * 16) = __cvt_16f64_to_16f16_rtz(v);

}
#endif
