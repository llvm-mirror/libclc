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


__attribute__((overloadable, always_inline, weak)) float2
vload2(size_t i, const float *p)
{
    return as_float2(vload2(i, (const int *)p));
}



__attribute__((overloadable, always_inline, weak)) float2
vload2(size_t i, const __constant float *p)
{
    return as_float2(vload2(i, (const __constant int *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float2
vload2(size_t i, const __global float *p)
{
    return as_float2(vload2(i, (const __global int *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float2
vload2(size_t i, const __local float *p)
{
    return as_float2(vload2(i, (const __local int *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) double2
vload2(size_t i, const double *p)
{
    return as_double2(vload2(i, (const long *)p));
}



__attribute__((overloadable, always_inline, weak)) double2
vload2(size_t i, const __constant double *p)
{
    return as_double2(vload2(i, (const __constant long *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double2
vload2(size_t i, const __global double *p)
{
    return as_double2(vload2(i, (const __global long *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double2
vload2(size_t i, const __local double *p)
{
    return as_double2(vload2(i, (const __local long *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) float3
vload3(size_t i, const float *p)
{
    return as_float3(vload3(i, (const int *)p));
}



__attribute__((overloadable, always_inline, weak)) float3
vload3(size_t i, const __constant float *p)
{
    return as_float3(vload3(i, (const __constant int *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float3
vload3(size_t i, const __global float *p)
{
    return as_float3(vload3(i, (const __global int *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float3
vload3(size_t i, const __local float *p)
{
    return as_float3(vload3(i, (const __local int *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) double3
vload3(size_t i, const double *p)
{
    return as_double3(vload3(i, (const long *)p));
}



__attribute__((overloadable, always_inline, weak)) double3
vload3(size_t i, const __constant double *p)
{
    return as_double3(vload3(i, (const __constant long *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double3
vload3(size_t i, const __global double *p)
{
    return as_double3(vload3(i, (const __global long *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double3
vload3(size_t i, const __local double *p)
{
    return as_double3(vload3(i, (const __local long *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) float4
vload4(size_t i, const float *p)
{
    return as_float4(vload4(i, (const int *)p));
}



__attribute__((overloadable, always_inline, weak)) float4
vload4(size_t i, const __constant float *p)
{
    return as_float4(vload4(i, (const __constant int *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float4
vload4(size_t i, const __global float *p)
{
    return as_float4(vload4(i, (const __global int *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float4
vload4(size_t i, const __local float *p)
{
    return as_float4(vload4(i, (const __local int *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) double4
vload4(size_t i, const double *p)
{
    return as_double4(vload4(i, (const long *)p));
}



__attribute__((overloadable, always_inline, weak)) double4
vload4(size_t i, const __constant double *p)
{
    return as_double4(vload4(i, (const __constant long *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double4
vload4(size_t i, const __global double *p)
{
    return as_double4(vload4(i, (const __global long *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double4
vload4(size_t i, const __local double *p)
{
    return as_double4(vload4(i, (const __local long *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) float8
vload8(size_t i, const float *p)
{
    return as_float8(vload8(i, (const int *)p));
}



__attribute__((overloadable, always_inline, weak)) float8
vload8(size_t i, const __constant float *p)
{
    return as_float8(vload8(i, (const __constant int *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float8
vload8(size_t i, const __global float *p)
{
    return as_float8(vload8(i, (const __global int *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float8
vload8(size_t i, const __local float *p)
{
    return as_float8(vload8(i, (const __local int *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) double8
vload8(size_t i, const double *p)
{
    return as_double8(vload8(i, (const long *)p));
}



__attribute__((overloadable, always_inline, weak)) double8
vload8(size_t i, const __constant double *p)
{
    return as_double8(vload8(i, (const __constant long *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double8
vload8(size_t i, const __global double *p)
{
    return as_double8(vload8(i, (const __global long *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double8
vload8(size_t i, const __local double *p)
{
    return as_double8(vload8(i, (const __local long *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) float16
vload16(size_t i, const float *p)
{
    return as_float16(vload16(i, (const int *)p));
}



__attribute__((overloadable, always_inline, weak)) float16
vload16(size_t i, const __constant float *p)
{
    return as_float16(vload16(i, (const __constant int *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float16
vload16(size_t i, const __global float *p)
{
    return as_float16(vload16(i, (const __global int *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) float16
vload16(size_t i, const __local float *p)
{
    return as_float16(vload16(i, (const __local int *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) double16
vload16(size_t i, const double *p)
{
    return as_double16(vload16(i, (const long *)p));
}



__attribute__((overloadable, always_inline, weak)) double16
vload16(size_t i, const __constant double *p)
{
    return as_double16(vload16(i, (const __constant long *)p));
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double16
vload16(size_t i, const __global double *p)
{
    return as_double16(vload16(i, (const __global long *)p));
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) double16
vload16(size_t i, const __local double *p)
{
    return as_double16(vload16(i, (const __local long *)p));
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore2(float2 v, size_t i, float *p)
{
    vstore2(as_int2(v), i, (int *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore2(float2 v, size_t i, __global float *p)
{
    vstore2(as_int2(v), i, (__global int *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore2(float2 v, size_t i, __local float *p)
{
    vstore2(as_int2(v), i, (__local int *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore2(double2 v, size_t i, double *p)
{
    vstore2(as_long2(v), i, (long *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore2(double2 v, size_t i, __global double *p)
{
    vstore2(as_long2(v), i, (__global long *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore2(double2 v, size_t i, __local double *p)
{
    vstore2(as_long2(v), i, (__local long *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore3(float3 v, size_t i, float *p)
{
    vstore3(as_int3(v), i, (int *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore3(float3 v, size_t i, __global float *p)
{
    vstore3(as_int3(v), i, (__global int *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore3(float3 v, size_t i, __local float *p)
{
    vstore3(as_int3(v), i, (__local int *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore3(double3 v, size_t i, double *p)
{
    vstore3(as_long3(v), i, (long *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore3(double3 v, size_t i, __global double *p)
{
    vstore3(as_long3(v), i, (__global long *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore3(double3 v, size_t i, __local double *p)
{
    vstore3(as_long3(v), i, (__local long *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore4(float4 v, size_t i, float *p)
{
    vstore4(as_int4(v), i, (int *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore4(float4 v, size_t i, __global float *p)
{
    vstore4(as_int4(v), i, (__global int *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore4(float4 v, size_t i, __local float *p)
{
    vstore4(as_int4(v), i, (__local int *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore4(double4 v, size_t i, double *p)
{
    vstore4(as_long4(v), i, (long *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore4(double4 v, size_t i, __global double *p)
{
    vstore4(as_long4(v), i, (__global long *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore4(double4 v, size_t i, __local double *p)
{
    vstore4(as_long4(v), i, (__local long *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore8(float8 v, size_t i, float *p)
{
    vstore8(as_int8(v), i, (int *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore8(float8 v, size_t i, __global float *p)
{
    vstore8(as_int8(v), i, (__global int *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore8(float8 v, size_t i, __local float *p)
{
    vstore8(as_int8(v), i, (__local int *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore8(double8 v, size_t i, double *p)
{
    vstore8(as_long8(v), i, (long *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore8(double8 v, size_t i, __global double *p)
{
    vstore8(as_long8(v), i, (__global long *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore8(double8 v, size_t i, __local double *p)
{
    vstore8(as_long8(v), i, (__local long *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore16(float16 v, size_t i, float *p)
{
    vstore16(as_int16(v), i, (int *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore16(float16 v, size_t i, __global float *p)
{
    vstore16(as_int16(v), i, (__global int *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore16(float16 v, size_t i, __local float *p)
{
    vstore16(as_int16(v), i, (__local int *)p);
}
#endif


__attribute__((overloadable, always_inline, weak)) void
vstore16(double16 v, size_t i, double *p)
{
    vstore16(as_long16(v), i, (long *)p);
}


#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore16(double16 v, size_t i, __global double *p)
{
    vstore16(as_long16(v), i, (__global long *)p);
}
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((overloadable, always_inline, weak)) void
vstore16(double16 v, size_t i, __local double *p)
{
    vstore16(as_long16(v), i, (__local long *)p);
}
#endif


__attribute__((always_inline)) static char2
vldp12(size_t i, const char *p)
{
    char2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp12")))  char2 vload2(size_t, const  char *);
extern __attribute__((overloadable, weak, alias("vldp12"))) uchar2 vload2(size_t, const uchar *);



__attribute__((always_inline)) static char2
vldc12(size_t i, const __constant char *p)
{
    char2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc12")))  char2 vload2(size_t, const __constant  char *);
extern __attribute__((overloadable, weak, alias("vldc12"))) uchar2 vload2(size_t, const __constant uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char2
vldg12(size_t i, const __global char *p)
{
    char2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg12")))  char2 vload2(size_t, const __global  char *);
extern __attribute__((overloadable, weak, alias("vldg12"))) uchar2 vload2(size_t, const __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char2
vldl12(size_t i, const __local char *p)
{
    char2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl12")))  char2 vload2(size_t, const __local  char *);
extern __attribute__((overloadable, weak, alias("vldl12"))) uchar2 vload2(size_t, const __local uchar *);
#endif


__attribute__((always_inline)) static short2
vldp22(size_t i, const short *p)
{
    short2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp22")))  short2 vload2(size_t, const  short *);
extern __attribute__((overloadable, weak, alias("vldp22"))) ushort2 vload2(size_t, const ushort *);



__attribute__((always_inline)) static short2
vldc22(size_t i, const __constant short *p)
{
    short2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc22")))  short2 vload2(size_t, const __constant  short *);
extern __attribute__((overloadable, weak, alias("vldc22"))) ushort2 vload2(size_t, const __constant ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short2
vldg22(size_t i, const __global short *p)
{
    short2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg22")))  short2 vload2(size_t, const __global  short *);
extern __attribute__((overloadable, weak, alias("vldg22"))) ushort2 vload2(size_t, const __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short2
vldl22(size_t i, const __local short *p)
{
    short2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl22")))  short2 vload2(size_t, const __local  short *);
extern __attribute__((overloadable, weak, alias("vldl22"))) ushort2 vload2(size_t, const __local ushort *);
#endif


__attribute__((always_inline)) static int2
vldp42(size_t i, const int *p)
{
    int2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp42")))  int2 vload2(size_t, const  int *);
extern __attribute__((overloadable, weak, alias("vldp42"))) uint2 vload2(size_t, const uint *);



__attribute__((always_inline)) static int2
vldc42(size_t i, const __constant int *p)
{
    int2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc42")))  int2 vload2(size_t, const __constant  int *);
extern __attribute__((overloadable, weak, alias("vldc42"))) uint2 vload2(size_t, const __constant uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int2
vldg42(size_t i, const __global int *p)
{
    int2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg42")))  int2 vload2(size_t, const __global  int *);
extern __attribute__((overloadable, weak, alias("vldg42"))) uint2 vload2(size_t, const __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int2
vldl42(size_t i, const __local int *p)
{
    int2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl42")))  int2 vload2(size_t, const __local  int *);
extern __attribute__((overloadable, weak, alias("vldl42"))) uint2 vload2(size_t, const __local uint *);
#endif


__attribute__((always_inline)) static long2
vldp82(size_t i, const long *p)
{
    long2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp82")))  long2 vload2(size_t, const  long *);
extern __attribute__((overloadable, weak, alias("vldp82"))) ulong2 vload2(size_t, const ulong *);



__attribute__((always_inline)) static long2
vldc82(size_t i, const __constant long *p)
{
    long2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc82")))  long2 vload2(size_t, const __constant  long *);
extern __attribute__((overloadable, weak, alias("vldc82"))) ulong2 vload2(size_t, const __constant ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long2
vldg82(size_t i, const __global long *p)
{
    long2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg82")))  long2 vload2(size_t, const __global  long *);
extern __attribute__((overloadable, weak, alias("vldg82"))) ulong2 vload2(size_t, const __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long2
vldl82(size_t i, const __local long *p)
{
    long2 ret;
    p += i * 2;
    ret.s0 = p[0];
    ret.s1 = p[1];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl82")))  long2 vload2(size_t, const __local  long *);
extern __attribute__((overloadable, weak, alias("vldl82"))) ulong2 vload2(size_t, const __local ulong *);
#endif


__attribute__((always_inline)) static char3
vldp13(size_t i, const char *p)
{
    char3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp13")))  char3 vload3(size_t, const  char *);
extern __attribute__((overloadable, weak, alias("vldp13"))) uchar3 vload3(size_t, const uchar *);



__attribute__((always_inline)) static char3
vldc13(size_t i, const __constant char *p)
{
    char3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc13")))  char3 vload3(size_t, const __constant  char *);
extern __attribute__((overloadable, weak, alias("vldc13"))) uchar3 vload3(size_t, const __constant uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char3
vldg13(size_t i, const __global char *p)
{
    char3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg13")))  char3 vload3(size_t, const __global  char *);
extern __attribute__((overloadable, weak, alias("vldg13"))) uchar3 vload3(size_t, const __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char3
vldl13(size_t i, const __local char *p)
{
    char3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl13")))  char3 vload3(size_t, const __local  char *);
extern __attribute__((overloadable, weak, alias("vldl13"))) uchar3 vload3(size_t, const __local uchar *);
#endif


__attribute__((always_inline)) static short3
vldp23(size_t i, const short *p)
{
    short3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp23")))  short3 vload3(size_t, const  short *);
extern __attribute__((overloadable, weak, alias("vldp23"))) ushort3 vload3(size_t, const ushort *);



__attribute__((always_inline)) static short3
vldc23(size_t i, const __constant short *p)
{
    short3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc23")))  short3 vload3(size_t, const __constant  short *);
extern __attribute__((overloadable, weak, alias("vldc23"))) ushort3 vload3(size_t, const __constant ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short3
vldg23(size_t i, const __global short *p)
{
    short3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg23")))  short3 vload3(size_t, const __global  short *);
extern __attribute__((overloadable, weak, alias("vldg23"))) ushort3 vload3(size_t, const __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short3
vldl23(size_t i, const __local short *p)
{
    short3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl23")))  short3 vload3(size_t, const __local  short *);
extern __attribute__((overloadable, weak, alias("vldl23"))) ushort3 vload3(size_t, const __local ushort *);
#endif


__attribute__((always_inline)) static int3
vldp43(size_t i, const int *p)
{
    int3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp43")))  int3 vload3(size_t, const  int *);
extern __attribute__((overloadable, weak, alias("vldp43"))) uint3 vload3(size_t, const uint *);



__attribute__((always_inline)) static int3
vldc43(size_t i, const __constant int *p)
{
    int3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc43")))  int3 vload3(size_t, const __constant  int *);
extern __attribute__((overloadable, weak, alias("vldc43"))) uint3 vload3(size_t, const __constant uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int3
vldg43(size_t i, const __global int *p)
{
    int3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg43")))  int3 vload3(size_t, const __global  int *);
extern __attribute__((overloadable, weak, alias("vldg43"))) uint3 vload3(size_t, const __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int3
vldl43(size_t i, const __local int *p)
{
    int3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl43")))  int3 vload3(size_t, const __local  int *);
extern __attribute__((overloadable, weak, alias("vldl43"))) uint3 vload3(size_t, const __local uint *);
#endif


__attribute__((always_inline)) static long3
vldp83(size_t i, const long *p)
{
    long3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp83")))  long3 vload3(size_t, const  long *);
extern __attribute__((overloadable, weak, alias("vldp83"))) ulong3 vload3(size_t, const ulong *);



__attribute__((always_inline)) static long3
vldc83(size_t i, const __constant long *p)
{
    long3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc83")))  long3 vload3(size_t, const __constant  long *);
extern __attribute__((overloadable, weak, alias("vldc83"))) ulong3 vload3(size_t, const __constant ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long3
vldg83(size_t i, const __global long *p)
{
    long3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg83")))  long3 vload3(size_t, const __global  long *);
extern __attribute__((overloadable, weak, alias("vldg83"))) ulong3 vload3(size_t, const __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long3
vldl83(size_t i, const __local long *p)
{
    long3 ret;
    p += i * 3;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl83")))  long3 vload3(size_t, const __local  long *);
extern __attribute__((overloadable, weak, alias("vldl83"))) ulong3 vload3(size_t, const __local ulong *);
#endif


__attribute__((always_inline)) static char4
vldp14(size_t i, const char *p)
{
    char4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp14")))  char4 vload4(size_t, const  char *);
extern __attribute__((overloadable, weak, alias("vldp14"))) uchar4 vload4(size_t, const uchar *);



__attribute__((always_inline)) static char4
vldc14(size_t i, const __constant char *p)
{
    char4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc14")))  char4 vload4(size_t, const __constant  char *);
extern __attribute__((overloadable, weak, alias("vldc14"))) uchar4 vload4(size_t, const __constant uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char4
vldg14(size_t i, const __global char *p)
{
    char4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg14")))  char4 vload4(size_t, const __global  char *);
extern __attribute__((overloadable, weak, alias("vldg14"))) uchar4 vload4(size_t, const __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char4
vldl14(size_t i, const __local char *p)
{
    char4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl14")))  char4 vload4(size_t, const __local  char *);
extern __attribute__((overloadable, weak, alias("vldl14"))) uchar4 vload4(size_t, const __local uchar *);
#endif


__attribute__((always_inline)) static short4
vldp24(size_t i, const short *p)
{
    short4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp24")))  short4 vload4(size_t, const  short *);
extern __attribute__((overloadable, weak, alias("vldp24"))) ushort4 vload4(size_t, const ushort *);



__attribute__((always_inline)) static short4
vldc24(size_t i, const __constant short *p)
{
    short4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc24")))  short4 vload4(size_t, const __constant  short *);
extern __attribute__((overloadable, weak, alias("vldc24"))) ushort4 vload4(size_t, const __constant ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short4
vldg24(size_t i, const __global short *p)
{
    short4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg24")))  short4 vload4(size_t, const __global  short *);
extern __attribute__((overloadable, weak, alias("vldg24"))) ushort4 vload4(size_t, const __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short4
vldl24(size_t i, const __local short *p)
{
    short4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl24")))  short4 vload4(size_t, const __local  short *);
extern __attribute__((overloadable, weak, alias("vldl24"))) ushort4 vload4(size_t, const __local ushort *);
#endif


__attribute__((always_inline)) static int4
vldp44(size_t i, const int *p)
{
    int4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp44")))  int4 vload4(size_t, const  int *);
extern __attribute__((overloadable, weak, alias("vldp44"))) uint4 vload4(size_t, const uint *);



__attribute__((always_inline)) static int4
vldc44(size_t i, const __constant int *p)
{
    int4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc44")))  int4 vload4(size_t, const __constant  int *);
extern __attribute__((overloadable, weak, alias("vldc44"))) uint4 vload4(size_t, const __constant uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int4
vldg44(size_t i, const __global int *p)
{
    int4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg44")))  int4 vload4(size_t, const __global  int *);
extern __attribute__((overloadable, weak, alias("vldg44"))) uint4 vload4(size_t, const __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int4
vldl44(size_t i, const __local int *p)
{
    int4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl44")))  int4 vload4(size_t, const __local  int *);
extern __attribute__((overloadable, weak, alias("vldl44"))) uint4 vload4(size_t, const __local uint *);
#endif


__attribute__((always_inline)) static long4
vldp84(size_t i, const long *p)
{
    long4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp84")))  long4 vload4(size_t, const  long *);
extern __attribute__((overloadable, weak, alias("vldp84"))) ulong4 vload4(size_t, const ulong *);



__attribute__((always_inline)) static long4
vldc84(size_t i, const __constant long *p)
{
    long4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc84")))  long4 vload4(size_t, const __constant  long *);
extern __attribute__((overloadable, weak, alias("vldc84"))) ulong4 vload4(size_t, const __constant ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long4
vldg84(size_t i, const __global long *p)
{
    long4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg84")))  long4 vload4(size_t, const __global  long *);
extern __attribute__((overloadable, weak, alias("vldg84"))) ulong4 vload4(size_t, const __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long4
vldl84(size_t i, const __local long *p)
{
    long4 ret;
    p += i * 4;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl84")))  long4 vload4(size_t, const __local  long *);
extern __attribute__((overloadable, weak, alias("vldl84"))) ulong4 vload4(size_t, const __local ulong *);
#endif


__attribute__((always_inline)) static char8
vldp18(size_t i, const char *p)
{
    char8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp18")))  char8 vload8(size_t, const  char *);
extern __attribute__((overloadable, weak, alias("vldp18"))) uchar8 vload8(size_t, const uchar *);



__attribute__((always_inline)) static char8
vldc18(size_t i, const __constant char *p)
{
    char8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc18")))  char8 vload8(size_t, const __constant  char *);
extern __attribute__((overloadable, weak, alias("vldc18"))) uchar8 vload8(size_t, const __constant uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char8
vldg18(size_t i, const __global char *p)
{
    char8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg18")))  char8 vload8(size_t, const __global  char *);
extern __attribute__((overloadable, weak, alias("vldg18"))) uchar8 vload8(size_t, const __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char8
vldl18(size_t i, const __local char *p)
{
    char8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl18")))  char8 vload8(size_t, const __local  char *);
extern __attribute__((overloadable, weak, alias("vldl18"))) uchar8 vload8(size_t, const __local uchar *);
#endif


__attribute__((always_inline)) static short8
vldp28(size_t i, const short *p)
{
    short8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp28")))  short8 vload8(size_t, const  short *);
extern __attribute__((overloadable, weak, alias("vldp28"))) ushort8 vload8(size_t, const ushort *);



__attribute__((always_inline)) static short8
vldc28(size_t i, const __constant short *p)
{
    short8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc28")))  short8 vload8(size_t, const __constant  short *);
extern __attribute__((overloadable, weak, alias("vldc28"))) ushort8 vload8(size_t, const __constant ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short8
vldg28(size_t i, const __global short *p)
{
    short8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg28")))  short8 vload8(size_t, const __global  short *);
extern __attribute__((overloadable, weak, alias("vldg28"))) ushort8 vload8(size_t, const __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short8
vldl28(size_t i, const __local short *p)
{
    short8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl28")))  short8 vload8(size_t, const __local  short *);
extern __attribute__((overloadable, weak, alias("vldl28"))) ushort8 vload8(size_t, const __local ushort *);
#endif


__attribute__((always_inline)) static int8
vldp48(size_t i, const int *p)
{
    int8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp48")))  int8 vload8(size_t, const  int *);
extern __attribute__((overloadable, weak, alias("vldp48"))) uint8 vload8(size_t, const uint *);



__attribute__((always_inline)) static int8
vldc48(size_t i, const __constant int *p)
{
    int8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc48")))  int8 vload8(size_t, const __constant  int *);
extern __attribute__((overloadable, weak, alias("vldc48"))) uint8 vload8(size_t, const __constant uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int8
vldg48(size_t i, const __global int *p)
{
    int8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg48")))  int8 vload8(size_t, const __global  int *);
extern __attribute__((overloadable, weak, alias("vldg48"))) uint8 vload8(size_t, const __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int8
vldl48(size_t i, const __local int *p)
{
    int8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl48")))  int8 vload8(size_t, const __local  int *);
extern __attribute__((overloadable, weak, alias("vldl48"))) uint8 vload8(size_t, const __local uint *);
#endif


__attribute__((always_inline)) static long8
vldp88(size_t i, const long *p)
{
    long8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp88")))  long8 vload8(size_t, const  long *);
extern __attribute__((overloadable, weak, alias("vldp88"))) ulong8 vload8(size_t, const ulong *);



__attribute__((always_inline)) static long8
vldc88(size_t i, const __constant long *p)
{
    long8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc88")))  long8 vload8(size_t, const __constant  long *);
extern __attribute__((overloadable, weak, alias("vldc88"))) ulong8 vload8(size_t, const __constant ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long8
vldg88(size_t i, const __global long *p)
{
    long8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg88")))  long8 vload8(size_t, const __global  long *);
extern __attribute__((overloadable, weak, alias("vldg88"))) ulong8 vload8(size_t, const __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long8
vldl88(size_t i, const __local long *p)
{
    long8 ret;
    p += i * 8;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl88")))  long8 vload8(size_t, const __local  long *);
extern __attribute__((overloadable, weak, alias("vldl88"))) ulong8 vload8(size_t, const __local ulong *);
#endif


__attribute__((always_inline)) static char16
vldp116(size_t i, const char *p)
{
    char16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp116")))  char16 vload16(size_t, const  char *);
extern __attribute__((overloadable, weak, alias("vldp116"))) uchar16 vload16(size_t, const uchar *);



__attribute__((always_inline)) static char16
vldc116(size_t i, const __constant char *p)
{
    char16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc116")))  char16 vload16(size_t, const __constant  char *);
extern __attribute__((overloadable, weak, alias("vldc116"))) uchar16 vload16(size_t, const __constant uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char16
vldg116(size_t i, const __global char *p)
{
    char16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg116")))  char16 vload16(size_t, const __global  char *);
extern __attribute__((overloadable, weak, alias("vldg116"))) uchar16 vload16(size_t, const __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static char16
vldl116(size_t i, const __local char *p)
{
    char16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl116")))  char16 vload16(size_t, const __local  char *);
extern __attribute__((overloadable, weak, alias("vldl116"))) uchar16 vload16(size_t, const __local uchar *);
#endif


__attribute__((always_inline)) static short16
vldp216(size_t i, const short *p)
{
    short16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp216")))  short16 vload16(size_t, const  short *);
extern __attribute__((overloadable, weak, alias("vldp216"))) ushort16 vload16(size_t, const ushort *);



__attribute__((always_inline)) static short16
vldc216(size_t i, const __constant short *p)
{
    short16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc216")))  short16 vload16(size_t, const __constant  short *);
extern __attribute__((overloadable, weak, alias("vldc216"))) ushort16 vload16(size_t, const __constant ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short16
vldg216(size_t i, const __global short *p)
{
    short16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg216")))  short16 vload16(size_t, const __global  short *);
extern __attribute__((overloadable, weak, alias("vldg216"))) ushort16 vload16(size_t, const __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static short16
vldl216(size_t i, const __local short *p)
{
    short16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl216")))  short16 vload16(size_t, const __local  short *);
extern __attribute__((overloadable, weak, alias("vldl216"))) ushort16 vload16(size_t, const __local ushort *);
#endif


__attribute__((always_inline)) static int16
vldp416(size_t i, const int *p)
{
    int16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp416")))  int16 vload16(size_t, const  int *);
extern __attribute__((overloadable, weak, alias("vldp416"))) uint16 vload16(size_t, const uint *);



__attribute__((always_inline)) static int16
vldc416(size_t i, const __constant int *p)
{
    int16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc416")))  int16 vload16(size_t, const __constant  int *);
extern __attribute__((overloadable, weak, alias("vldc416"))) uint16 vload16(size_t, const __constant uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int16
vldg416(size_t i, const __global int *p)
{
    int16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg416")))  int16 vload16(size_t, const __global  int *);
extern __attribute__((overloadable, weak, alias("vldg416"))) uint16 vload16(size_t, const __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static int16
vldl416(size_t i, const __local int *p)
{
    int16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl416")))  int16 vload16(size_t, const __local  int *);
extern __attribute__((overloadable, weak, alias("vldl416"))) uint16 vload16(size_t, const __local uint *);
#endif


__attribute__((always_inline)) static long16
vldp816(size_t i, const long *p)
{
    long16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldp816")))  long16 vload16(size_t, const  long *);
extern __attribute__((overloadable, weak, alias("vldp816"))) ulong16 vload16(size_t, const ulong *);



__attribute__((always_inline)) static long16
vldc816(size_t i, const __constant long *p)
{
    long16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldc816")))  long16 vload16(size_t, const __constant  long *);
extern __attribute__((overloadable, weak, alias("vldc816"))) ulong16 vload16(size_t, const __constant ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long16
vldg816(size_t i, const __global long *p)
{
    long16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldg816")))  long16 vload16(size_t, const __global  long *);
extern __attribute__((overloadable, weak, alias("vldg816"))) ulong16 vload16(size_t, const __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static long16
vldl816(size_t i, const __local long *p)
{
    long16 ret;
    p += i * 16;
    ret.s0 = p[0];
    ret.s1 = p[1];
    ret.s2 = p[2];
    ret.s3 = p[3];
    ret.s4 = p[4];
    ret.s5 = p[5];
    ret.s6 = p[6];
    ret.s7 = p[7];
    ret.s8 = p[8];
    ret.s9 = p[9];
    ret.sa = p[10];
    ret.sb = p[11];
    ret.sc = p[12];
    ret.sd = p[13];
    ret.se = p[14];
    ret.sf = p[15];

    return ret;
}
extern __attribute__((overloadable, weak, alias("vldl816")))  long16 vload16(size_t, const __local  long *);
extern __attribute__((overloadable, weak, alias("vldl816"))) ulong16 vload16(size_t, const __local ulong *);
#endif


__attribute__((always_inline)) static void
vstp12(char2 v, size_t i, char *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstp12"))) void vstore2( char2, size_t,  char *);
extern __attribute__((overloadable, weak, alias("vstp12"))) void vstore2(uchar2, size_t, uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg12(char2 v, size_t i, __global char *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstg12"))) void vstore2( char2, size_t, __global  char *);
extern __attribute__((overloadable, weak, alias("vstg12"))) void vstore2(uchar2, size_t, __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl12(char2 v, size_t i, __local char *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstl12"))) void vstore2( char2, size_t, __local  char *);
extern __attribute__((overloadable, weak, alias("vstl12"))) void vstore2(uchar2, size_t, __local uchar *);
#endif


__attribute__((always_inline)) static void
vstp22(short2 v, size_t i, short *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstp22"))) void vstore2( short2, size_t,  short *);
extern __attribute__((overloadable, weak, alias("vstp22"))) void vstore2(ushort2, size_t, ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg22(short2 v, size_t i, __global short *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstg22"))) void vstore2( short2, size_t, __global  short *);
extern __attribute__((overloadable, weak, alias("vstg22"))) void vstore2(ushort2, size_t, __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl22(short2 v, size_t i, __local short *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstl22"))) void vstore2( short2, size_t, __local  short *);
extern __attribute__((overloadable, weak, alias("vstl22"))) void vstore2(ushort2, size_t, __local ushort *);
#endif


__attribute__((always_inline)) static void
vstp42(int2 v, size_t i, int *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstp42"))) void vstore2( int2, size_t,  int *);
extern __attribute__((overloadable, weak, alias("vstp42"))) void vstore2(uint2, size_t, uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg42(int2 v, size_t i, __global int *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstg42"))) void vstore2( int2, size_t, __global  int *);
extern __attribute__((overloadable, weak, alias("vstg42"))) void vstore2(uint2, size_t, __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl42(int2 v, size_t i, __local int *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstl42"))) void vstore2( int2, size_t, __local  int *);
extern __attribute__((overloadable, weak, alias("vstl42"))) void vstore2(uint2, size_t, __local uint *);
#endif


__attribute__((always_inline)) static void
vstp82(long2 v, size_t i, long *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstp82"))) void vstore2( long2, size_t,  long *);
extern __attribute__((overloadable, weak, alias("vstp82"))) void vstore2(ulong2, size_t, ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg82(long2 v, size_t i, __global long *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstg82"))) void vstore2( long2, size_t, __global  long *);
extern __attribute__((overloadable, weak, alias("vstg82"))) void vstore2(ulong2, size_t, __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl82(long2 v, size_t i, __local long *p)
{
    p += i * 2;
    p[0] = v.s0;
    p[1] = v.s1;

}
extern __attribute__((overloadable, weak, alias("vstl82"))) void vstore2( long2, size_t, __local  long *);
extern __attribute__((overloadable, weak, alias("vstl82"))) void vstore2(ulong2, size_t, __local ulong *);
#endif


__attribute__((always_inline)) static void
vstp13(char3 v, size_t i, char *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstp13"))) void vstore3( char3, size_t,  char *);
extern __attribute__((overloadable, weak, alias("vstp13"))) void vstore3(uchar3, size_t, uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg13(char3 v, size_t i, __global char *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstg13"))) void vstore3( char3, size_t, __global  char *);
extern __attribute__((overloadable, weak, alias("vstg13"))) void vstore3(uchar3, size_t, __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl13(char3 v, size_t i, __local char *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstl13"))) void vstore3( char3, size_t, __local  char *);
extern __attribute__((overloadable, weak, alias("vstl13"))) void vstore3(uchar3, size_t, __local uchar *);
#endif


__attribute__((always_inline)) static void
vstp23(short3 v, size_t i, short *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstp23"))) void vstore3( short3, size_t,  short *);
extern __attribute__((overloadable, weak, alias("vstp23"))) void vstore3(ushort3, size_t, ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg23(short3 v, size_t i, __global short *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstg23"))) void vstore3( short3, size_t, __global  short *);
extern __attribute__((overloadable, weak, alias("vstg23"))) void vstore3(ushort3, size_t, __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl23(short3 v, size_t i, __local short *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstl23"))) void vstore3( short3, size_t, __local  short *);
extern __attribute__((overloadable, weak, alias("vstl23"))) void vstore3(ushort3, size_t, __local ushort *);
#endif


__attribute__((always_inline)) static void
vstp43(int3 v, size_t i, int *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstp43"))) void vstore3( int3, size_t,  int *);
extern __attribute__((overloadable, weak, alias("vstp43"))) void vstore3(uint3, size_t, uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg43(int3 v, size_t i, __global int *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstg43"))) void vstore3( int3, size_t, __global  int *);
extern __attribute__((overloadable, weak, alias("vstg43"))) void vstore3(uint3, size_t, __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl43(int3 v, size_t i, __local int *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstl43"))) void vstore3( int3, size_t, __local  int *);
extern __attribute__((overloadable, weak, alias("vstl43"))) void vstore3(uint3, size_t, __local uint *);
#endif


__attribute__((always_inline)) static void
vstp83(long3 v, size_t i, long *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstp83"))) void vstore3( long3, size_t,  long *);
extern __attribute__((overloadable, weak, alias("vstp83"))) void vstore3(ulong3, size_t, ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg83(long3 v, size_t i, __global long *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstg83"))) void vstore3( long3, size_t, __global  long *);
extern __attribute__((overloadable, weak, alias("vstg83"))) void vstore3(ulong3, size_t, __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl83(long3 v, size_t i, __local long *p)
{
    p += i * 3;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;

}
extern __attribute__((overloadable, weak, alias("vstl83"))) void vstore3( long3, size_t, __local  long *);
extern __attribute__((overloadable, weak, alias("vstl83"))) void vstore3(ulong3, size_t, __local ulong *);
#endif


__attribute__((always_inline)) static void
vstp14(char4 v, size_t i, char *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstp14"))) void vstore4( char4, size_t,  char *);
extern __attribute__((overloadable, weak, alias("vstp14"))) void vstore4(uchar4, size_t, uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg14(char4 v, size_t i, __global char *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstg14"))) void vstore4( char4, size_t, __global  char *);
extern __attribute__((overloadable, weak, alias("vstg14"))) void vstore4(uchar4, size_t, __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl14(char4 v, size_t i, __local char *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstl14"))) void vstore4( char4, size_t, __local  char *);
extern __attribute__((overloadable, weak, alias("vstl14"))) void vstore4(uchar4, size_t, __local uchar *);
#endif


__attribute__((always_inline)) static void
vstp24(short4 v, size_t i, short *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstp24"))) void vstore4( short4, size_t,  short *);
extern __attribute__((overloadable, weak, alias("vstp24"))) void vstore4(ushort4, size_t, ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg24(short4 v, size_t i, __global short *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstg24"))) void vstore4( short4, size_t, __global  short *);
extern __attribute__((overloadable, weak, alias("vstg24"))) void vstore4(ushort4, size_t, __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl24(short4 v, size_t i, __local short *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstl24"))) void vstore4( short4, size_t, __local  short *);
extern __attribute__((overloadable, weak, alias("vstl24"))) void vstore4(ushort4, size_t, __local ushort *);
#endif


__attribute__((always_inline)) static void
vstp44(int4 v, size_t i, int *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstp44"))) void vstore4( int4, size_t,  int *);
extern __attribute__((overloadable, weak, alias("vstp44"))) void vstore4(uint4, size_t, uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg44(int4 v, size_t i, __global int *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstg44"))) void vstore4( int4, size_t, __global  int *);
extern __attribute__((overloadable, weak, alias("vstg44"))) void vstore4(uint4, size_t, __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl44(int4 v, size_t i, __local int *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstl44"))) void vstore4( int4, size_t, __local  int *);
extern __attribute__((overloadable, weak, alias("vstl44"))) void vstore4(uint4, size_t, __local uint *);
#endif


__attribute__((always_inline)) static void
vstp84(long4 v, size_t i, long *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstp84"))) void vstore4( long4, size_t,  long *);
extern __attribute__((overloadable, weak, alias("vstp84"))) void vstore4(ulong4, size_t, ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg84(long4 v, size_t i, __global long *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstg84"))) void vstore4( long4, size_t, __global  long *);
extern __attribute__((overloadable, weak, alias("vstg84"))) void vstore4(ulong4, size_t, __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl84(long4 v, size_t i, __local long *p)
{
    p += i * 4;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;

}
extern __attribute__((overloadable, weak, alias("vstl84"))) void vstore4( long4, size_t, __local  long *);
extern __attribute__((overloadable, weak, alias("vstl84"))) void vstore4(ulong4, size_t, __local ulong *);
#endif


__attribute__((always_inline)) static void
vstp18(char8 v, size_t i, char *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstp18"))) void vstore8( char8, size_t,  char *);
extern __attribute__((overloadable, weak, alias("vstp18"))) void vstore8(uchar8, size_t, uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg18(char8 v, size_t i, __global char *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstg18"))) void vstore8( char8, size_t, __global  char *);
extern __attribute__((overloadable, weak, alias("vstg18"))) void vstore8(uchar8, size_t, __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl18(char8 v, size_t i, __local char *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstl18"))) void vstore8( char8, size_t, __local  char *);
extern __attribute__((overloadable, weak, alias("vstl18"))) void vstore8(uchar8, size_t, __local uchar *);
#endif


__attribute__((always_inline)) static void
vstp28(short8 v, size_t i, short *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstp28"))) void vstore8( short8, size_t,  short *);
extern __attribute__((overloadable, weak, alias("vstp28"))) void vstore8(ushort8, size_t, ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg28(short8 v, size_t i, __global short *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstg28"))) void vstore8( short8, size_t, __global  short *);
extern __attribute__((overloadable, weak, alias("vstg28"))) void vstore8(ushort8, size_t, __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl28(short8 v, size_t i, __local short *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstl28"))) void vstore8( short8, size_t, __local  short *);
extern __attribute__((overloadable, weak, alias("vstl28"))) void vstore8(ushort8, size_t, __local ushort *);
#endif


__attribute__((always_inline)) static void
vstp48(int8 v, size_t i, int *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstp48"))) void vstore8( int8, size_t,  int *);
extern __attribute__((overloadable, weak, alias("vstp48"))) void vstore8(uint8, size_t, uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg48(int8 v, size_t i, __global int *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstg48"))) void vstore8( int8, size_t, __global  int *);
extern __attribute__((overloadable, weak, alias("vstg48"))) void vstore8(uint8, size_t, __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl48(int8 v, size_t i, __local int *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstl48"))) void vstore8( int8, size_t, __local  int *);
extern __attribute__((overloadable, weak, alias("vstl48"))) void vstore8(uint8, size_t, __local uint *);
#endif


__attribute__((always_inline)) static void
vstp88(long8 v, size_t i, long *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstp88"))) void vstore8( long8, size_t,  long *);
extern __attribute__((overloadable, weak, alias("vstp88"))) void vstore8(ulong8, size_t, ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg88(long8 v, size_t i, __global long *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstg88"))) void vstore8( long8, size_t, __global  long *);
extern __attribute__((overloadable, weak, alias("vstg88"))) void vstore8(ulong8, size_t, __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl88(long8 v, size_t i, __local long *p)
{
    p += i * 8;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;

}
extern __attribute__((overloadable, weak, alias("vstl88"))) void vstore8( long8, size_t, __local  long *);
extern __attribute__((overloadable, weak, alias("vstl88"))) void vstore8(ulong8, size_t, __local ulong *);
#endif


__attribute__((always_inline)) static void
vstp116(char16 v, size_t i, char *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstp116"))) void vstore16( char16, size_t,  char *);
extern __attribute__((overloadable, weak, alias("vstp116"))) void vstore16(uchar16, size_t, uchar *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg116(char16 v, size_t i, __global char *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstg116"))) void vstore16( char16, size_t, __global  char *);
extern __attribute__((overloadable, weak, alias("vstg116"))) void vstore16(uchar16, size_t, __global uchar *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl116(char16 v, size_t i, __local char *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstl116"))) void vstore16( char16, size_t, __local  char *);
extern __attribute__((overloadable, weak, alias("vstl116"))) void vstore16(uchar16, size_t, __local uchar *);
#endif


__attribute__((always_inline)) static void
vstp216(short16 v, size_t i, short *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstp216"))) void vstore16( short16, size_t,  short *);
extern __attribute__((overloadable, weak, alias("vstp216"))) void vstore16(ushort16, size_t, ushort *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg216(short16 v, size_t i, __global short *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstg216"))) void vstore16( short16, size_t, __global  short *);
extern __attribute__((overloadable, weak, alias("vstg216"))) void vstore16(ushort16, size_t, __global ushort *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl216(short16 v, size_t i, __local short *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstl216"))) void vstore16( short16, size_t, __local  short *);
extern __attribute__((overloadable, weak, alias("vstl216"))) void vstore16(ushort16, size_t, __local ushort *);
#endif


__attribute__((always_inline)) static void
vstp416(int16 v, size_t i, int *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstp416"))) void vstore16( int16, size_t,  int *);
extern __attribute__((overloadable, weak, alias("vstp416"))) void vstore16(uint16, size_t, uint *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg416(int16 v, size_t i, __global int *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstg416"))) void vstore16( int16, size_t, __global  int *);
extern __attribute__((overloadable, weak, alias("vstg416"))) void vstore16(uint16, size_t, __global uint *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl416(int16 v, size_t i, __local int *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstl416"))) void vstore16( int16, size_t, __local  int *);
extern __attribute__((overloadable, weak, alias("vstl416"))) void vstore16(uint16, size_t, __local uint *);
#endif


__attribute__((always_inline)) static void
vstp816(long16 v, size_t i, long *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstp816"))) void vstore16( long16, size_t,  long *);
extern __attribute__((overloadable, weak, alias("vstp816"))) void vstore16(ulong16, size_t, ulong *);


#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstg816(long16 v, size_t i, __global long *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstg816"))) void vstore16( long16, size_t, __global  long *);
extern __attribute__((overloadable, weak, alias("vstg816"))) void vstore16(ulong16, size_t, __global ulong *);
#endif

#if __OPENCL_C_VERSION__ < 200
__attribute__((always_inline)) static void
vstl816(long16 v, size_t i, __local long *p)
{
    p += i * 16;
    p[0] = v.s0;
    p[1] = v.s1;
    p[2] = v.s2;
    p[3] = v.s3;
    p[4] = v.s4;
    p[5] = v.s5;
    p[6] = v.s6;
    p[7] = v.s7;
    p[8] = v.s8;
    p[9] = v.s9;
    p[10] = v.sa;
    p[11] = v.sb;
    p[12] = v.sc;
    p[13] = v.sd;
    p[14] = v.se;
    p[15] = v.sf;

}
extern __attribute__((overloadable, weak, alias("vstl816"))) void vstore16( long16, size_t, __local  long *);
extern __attribute__((overloadable, weak, alias("vstl816"))) void vstore16(ulong16, size_t, __local ulong *);
#endif

