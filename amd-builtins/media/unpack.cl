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

#include "media.h"

__attribute__((overloadable, always_inline)) float
amd_unpack0(uint a)
{
    return __hsail_unpackcvt_f32_u8x4(a,0);
}

__attribute__((overloadable, always_inline)) float2
amd_unpack0(uint2 a)
{
    float2 ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,0);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,0);
    return ret;
}

__attribute__((overloadable, always_inline)) float3
amd_unpack0(uint3 a)
{

    float3  ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,0);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,0);
    ret.z =  __hsail_unpackcvt_f32_u8x4(a.z,0);
    return ret;

}

__attribute__((overloadable, always_inline)) float4
amd_unpack0(uint4 a)
{
    float4 ret;
    ret.x = __hsail_unpackcvt_f32_u8x4(a.x,0);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,0);
    ret.z =  __hsail_unpackcvt_f32_u8x4(a.z,0);
    ret.w =  __hsail_unpackcvt_f32_u8x4(a.w,0);
    return ret;
}

__attribute__((overloadable, always_inline)) float8
amd_unpack0(uint8 a)
{
    float8 ret;
    ret.s0 =  __hsail_unpackcvt_f32_u8x4(a.s0,0);
    ret.s1 =  __hsail_unpackcvt_f32_u8x4(a.s1,0);
    ret.s2 =  __hsail_unpackcvt_f32_u8x4(a.s2,0);
    ret.s3 =  __hsail_unpackcvt_f32_u8x4(a.s3,0);
    ret.s4 =  __hsail_unpackcvt_f32_u8x4(a.s4,0);
    ret.s5 =  __hsail_unpackcvt_f32_u8x4(a.s5,0);
    ret.s6 =  __hsail_unpackcvt_f32_u8x4(a.s6,0);
    ret.s7 =  __hsail_unpackcvt_f32_u8x4(a.s7,0);
    return ret;
}

__attribute__((overloadable, always_inline)) float16
amd_unpack0(uint16 a)
{
    float16 ret;
    ret.s0 =  __hsail_unpackcvt_f32_u8x4(a.s0,0);
    ret.s1 =  __hsail_unpackcvt_f32_u8x4(a.s1,0);
    ret.s2 =  __hsail_unpackcvt_f32_u8x4(a.s2,0);
    ret.s3 =  __hsail_unpackcvt_f32_u8x4(a.s3,0);
    ret.s4 =  __hsail_unpackcvt_f32_u8x4(a.s4,0);
    ret.s5 =  __hsail_unpackcvt_f32_u8x4(a.s5,0);
    ret.s6 =  __hsail_unpackcvt_f32_u8x4(a.s6,0);
    ret.s7 =  __hsail_unpackcvt_f32_u8x4(a.s7,0);
    ret.s8 =  __hsail_unpackcvt_f32_u8x4(a.s8,0);
    ret.s9 =  __hsail_unpackcvt_f32_u8x4(a.s9,0);
    ret.sa =  __hsail_unpackcvt_f32_u8x4(a.sa,0);
    ret.sb =  __hsail_unpackcvt_f32_u8x4(a.sb,0);
    ret.sc =  __hsail_unpackcvt_f32_u8x4(a.sc,0);
    ret.sd =  __hsail_unpackcvt_f32_u8x4(a.sd,0);
    ret.se =  __hsail_unpackcvt_f32_u8x4(a.se,0);
    ret.sf =  __hsail_unpackcvt_f32_u8x4(a.sf,0);
    return ret;
}

__attribute__((overloadable, always_inline)) float
amd_unpack1(uint a)
{
    return __hsail_unpackcvt_f32_u8x4(a,1);
}

__attribute__((overloadable, always_inline)) float2
amd_unpack1(uint2 a)
{
    float2 ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,1);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,1);
    return ret;
}

__attribute__((overloadable, always_inline)) float3
amd_unpack1(uint3 a)
{

    float3  ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,1);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,1);
    ret.z =  __hsail_unpackcvt_f32_u8x4(a.z,1);
    return ret;

}

__attribute__((overloadable, always_inline)) float4
amd_unpack1(uint4 a)
{
    float4 ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,1);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,1);
    ret.z =  __hsail_unpackcvt_f32_u8x4(a.z,1);
    ret.w =  __hsail_unpackcvt_f32_u8x4(a.w,1);
    return ret;
}

__attribute__((overloadable, always_inline)) float8
amd_unpack1(uint8 a)
{
    float8 ret;
    ret.s0 =  __hsail_unpackcvt_f32_u8x4(a.s0,1);
    ret.s1 =  __hsail_unpackcvt_f32_u8x4(a.s1,1);
    ret.s2 =  __hsail_unpackcvt_f32_u8x4(a.s2,1);
    ret.s3 =  __hsail_unpackcvt_f32_u8x4(a.s3,1);
    ret.s4 =  __hsail_unpackcvt_f32_u8x4(a.s4,1);
    ret.s5 =  __hsail_unpackcvt_f32_u8x4(a.s5,1);
    ret.s6 =  __hsail_unpackcvt_f32_u8x4(a.s6,1);
    ret.s7 =  __hsail_unpackcvt_f32_u8x4(a.s7,1);
    return ret;
}

__attribute__((overloadable, always_inline)) float16
amd_unpack1(uint16 a)
{
    float16 ret;
    ret.s0 =  __hsail_unpackcvt_f32_u8x4(a.s0,1);
    ret.s1 =  __hsail_unpackcvt_f32_u8x4(a.s1,1);
    ret.s2 =  __hsail_unpackcvt_f32_u8x4(a.s2,1);
    ret.s3 =  __hsail_unpackcvt_f32_u8x4(a.s3,1);
    ret.s4 =  __hsail_unpackcvt_f32_u8x4(a.s4,1);
    ret.s5 =  __hsail_unpackcvt_f32_u8x4(a.s5,1);
    ret.s6 =  __hsail_unpackcvt_f32_u8x4(a.s6,1);
    ret.s7 =  __hsail_unpackcvt_f32_u8x4(a.s7,1);
    ret.s8 =  __hsail_unpackcvt_f32_u8x4(a.s8,1);
    ret.s9 =  __hsail_unpackcvt_f32_u8x4(a.s9,1);
    ret.sa =  __hsail_unpackcvt_f32_u8x4(a.sa,1);
    ret.sb =  __hsail_unpackcvt_f32_u8x4(a.sb,1);
    ret.sc =  __hsail_unpackcvt_f32_u8x4(a.sc,1);
    ret.sd =  __hsail_unpackcvt_f32_u8x4(a.sd,1);
    ret.se =  __hsail_unpackcvt_f32_u8x4(a.se,1);
    ret.sf =  __hsail_unpackcvt_f32_u8x4(a.sf,1);
    return ret;
}

__attribute__((overloadable, always_inline)) float
amd_unpack2(uint a)
{
    return __hsail_unpackcvt_f32_u8x4(a,2);
}

__attribute__((overloadable, always_inline)) float2
amd_unpack2(uint2 a)
{
    float2 ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,2);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,2);
    return ret;
}

__attribute__((overloadable, always_inline)) float3
amd_unpack2(uint3 a)
{

    float3  ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,2);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,2);
    ret.z =  __hsail_unpackcvt_f32_u8x4(a.z,2);
    return ret;

}

__attribute__((overloadable, always_inline)) float4
amd_unpack2(uint4 a)
{
    float4 ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,2);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,2);
    ret.z =  __hsail_unpackcvt_f32_u8x4(a.z,2);
    ret.w =  __hsail_unpackcvt_f32_u8x4(a.w,2);
    return ret;
}

__attribute__((overloadable, always_inline)) float8
amd_unpack2(uint8 a)
{
    float8 ret;
    ret.s0 =  __hsail_unpackcvt_f32_u8x4(a.s0,2);
    ret.s1 =  __hsail_unpackcvt_f32_u8x4(a.s1,2);
    ret.s2 =  __hsail_unpackcvt_f32_u8x4(a.s2,2);
    ret.s3 =  __hsail_unpackcvt_f32_u8x4(a.s3,2);
    ret.s4 =  __hsail_unpackcvt_f32_u8x4(a.s4,2);
    ret.s5 =  __hsail_unpackcvt_f32_u8x4(a.s5,2);
    ret.s6 =  __hsail_unpackcvt_f32_u8x4(a.s6,2);
    ret.s7 =  __hsail_unpackcvt_f32_u8x4(a.s7,2);
    return ret;
}

__attribute__((overloadable, always_inline)) float16
amd_unpack2(uint16 a)
{
    float16 ret;
    ret.s0 =  __hsail_unpackcvt_f32_u8x4(a.s0,2);
    ret.s1 =  __hsail_unpackcvt_f32_u8x4(a.s1,2);
    ret.s2 =  __hsail_unpackcvt_f32_u8x4(a.s2,2);
    ret.s3 =  __hsail_unpackcvt_f32_u8x4(a.s3,2);
    ret.s4 =  __hsail_unpackcvt_f32_u8x4(a.s4,2);
    ret.s5 =  __hsail_unpackcvt_f32_u8x4(a.s5,2);
    ret.s6 =  __hsail_unpackcvt_f32_u8x4(a.s6,2);
    ret.s7 =  __hsail_unpackcvt_f32_u8x4(a.s7,2);
    ret.s8 =  __hsail_unpackcvt_f32_u8x4(a.s8,2);
    ret.s9 =  __hsail_unpackcvt_f32_u8x4(a.s9,2);
    ret.sa =  __hsail_unpackcvt_f32_u8x4(a.sa,2);
    ret.sb =  __hsail_unpackcvt_f32_u8x4(a.sb,2);
    ret.sc =  __hsail_unpackcvt_f32_u8x4(a.sc,2);
    ret.sd =  __hsail_unpackcvt_f32_u8x4(a.sd,2);
    ret.se =  __hsail_unpackcvt_f32_u8x4(a.se,2);
    ret.sf =  __hsail_unpackcvt_f32_u8x4(a.sf,2);
    return ret;
}

__attribute__((overloadable, always_inline)) float
amd_unpack3(uint a)
{
    return __hsail_unpackcvt_f32_u8x4(a,3);
}

__attribute__((overloadable, always_inline)) float2
amd_unpack3(uint2 a)
{
    float2 ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,3);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,3);
    return ret;
}

__attribute__((overloadable, always_inline)) float3
amd_unpack3(uint3 a)
{

    float3  ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,3);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,3);
    ret.z =  __hsail_unpackcvt_f32_u8x4(a.z,3);
    return ret;

}

__attribute__((overloadable, always_inline)) float4
amd_unpack3(uint4 a)
{
    float4 ret;
    ret.x =  __hsail_unpackcvt_f32_u8x4(a.x,3);
    ret.y =  __hsail_unpackcvt_f32_u8x4(a.y,3);
    ret.z =  __hsail_unpackcvt_f32_u8x4(a.z,3);
    ret.w =  __hsail_unpackcvt_f32_u8x4(a.w,3);
    return ret;
}

__attribute__((overloadable, always_inline)) float8
amd_unpack3(uint8 a)
{
    float8 ret;
    ret.s0 =  __hsail_unpackcvt_f32_u8x4(a.s0,3);
    ret.s1 =  __hsail_unpackcvt_f32_u8x4(a.s1,3);
    ret.s2 =  __hsail_unpackcvt_f32_u8x4(a.s2,3);
    ret.s3 =  __hsail_unpackcvt_f32_u8x4(a.s3,3);
    ret.s4 =  __hsail_unpackcvt_f32_u8x4(a.s4,3);
    ret.s5 =  __hsail_unpackcvt_f32_u8x4(a.s5,3);
    ret.s6 =  __hsail_unpackcvt_f32_u8x4(a.s6,3);
    ret.s7 =  __hsail_unpackcvt_f32_u8x4(a.s7,3);
    return ret;
}

__attribute__((overloadable, always_inline)) float16
amd_unpack3(uint16 a)
{
    float16 ret;
    ret.s0 =  __hsail_unpackcvt_f32_u8x4(a.s0,3);
    ret.s1 =  __hsail_unpackcvt_f32_u8x4(a.s1,3);
    ret.s2 =  __hsail_unpackcvt_f32_u8x4(a.s2,3);
    ret.s3 =  __hsail_unpackcvt_f32_u8x4(a.s3,3);
    ret.s4 =  __hsail_unpackcvt_f32_u8x4(a.s4,3);
    ret.s5 =  __hsail_unpackcvt_f32_u8x4(a.s5,3);
    ret.s6 =  __hsail_unpackcvt_f32_u8x4(a.s6,3);
    ret.s7 =  __hsail_unpackcvt_f32_u8x4(a.s7,3);
    ret.s8 =  __hsail_unpackcvt_f32_u8x4(a.s8,3);
    ret.s9 =  __hsail_unpackcvt_f32_u8x4(a.s9,3);
    ret.sa =  __hsail_unpackcvt_f32_u8x4(a.sa,3);
    ret.sb =  __hsail_unpackcvt_f32_u8x4(a.sb,3);
    ret.sc =  __hsail_unpackcvt_f32_u8x4(a.sc,3);
    ret.sd =  __hsail_unpackcvt_f32_u8x4(a.sd,3);
    ret.se =  __hsail_unpackcvt_f32_u8x4(a.se,3);
    ret.sf =  __hsail_unpackcvt_f32_u8x4(a.sf,3);
    return ret;
}
