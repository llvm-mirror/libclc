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

// #pragma OPENCL EXTENSION cl_khr_fp64 : enable

#define ConvIntrinPrototype(FromTy,FromSuf,ToTy,ToSuf,Rnd)  \
extern __attribute__((pure)) \
ToTy __cvt_##ToSuf##_##Rnd##_##FromSuf(FromTy); 

#define ConvIntrinPrototypeSet(FromTy,FromSuf,ToTy,ToSuf)  \
  ConvIntrinPrototype(FromTy,FromSuf,ToTy,ToSuf,rte)  \
  ConvIntrinPrototype(FromTy,FromSuf,ToTy,ToSuf,rtn)  \
  ConvIntrinPrototype(FromTy,FromSuf,ToTy,ToSuf,rtp)  \
  ConvIntrinPrototype(FromTy,FromSuf,ToTy,ToSuf,rtz)

#define FloatToIntegerRoundingConv(FromTy,FromSuf,ToTy,ToSuf,Rnd)  \
__attribute__((always_inline)) ToTy \
__convert_##ToTy##_##Rnd##_##FromSuf(FromTy x) { \
  return (ToTy)__cvt_##ToSuf##_##Rnd##_##FromSuf(x);  \
}

#define FloatToIntegerSatRoundingConv(FromTy,FromSuf,ToTy,ToSuf,Rnd,Min,Max)  \
__attribute__((always_inline)) ToTy \
__convert_##ToTy##_sat_##Rnd##_##FromSuf(FromTy x) { \
  ToTy r; \
  if (sizeof(ToTy) >= sizeof(long)) { \
    r = (ToTy)__cvt_##ToSuf##_##Rnd##_##FromSuf(x);  \
    bool le = (x <= (FromTy)Min);  \
    bool ge = (x >= (FromTy)Max);  \
    r = le?((ToTy) Min):r; \
    r = ge?((ToTy) Max):r; \
  } else { \
    FromTy s = min(max(x, (FromTy)Min), (FromTy)Max); \
    r = (ToTy)__cvt_##ToSuf##_##Rnd##_##FromSuf(s);  \
  } \
  return r; \
}

#define FloatToUnsignedSatRoundingConv(FromTy,FromSuf,ToTy,ToSuf,Rnd,Max)  \
__attribute__((always_inline)) ToTy \
__convert_##ToTy##_sat_##Rnd##_##FromSuf(FromTy x) { \
  ToTy r; \
  if (sizeof(ToTy) >= sizeof(long)) { \
    r = (ToTy)__cvt_##ToSuf##_##Rnd##_##FromSuf(x);  \
    bool le = (x <= (FromTy)0);  \
    bool ge = (x >= (FromTy)Max);  \
    r = le?((ToTy) 0):r; \
    r = ge?((ToTy) Max):r; \
  } else { \
    FromTy s = min(max(x, (FromTy)0), (FromTy)Max); \
    r = (ToTy)__cvt_##ToSuf##_##Rnd##_##FromSuf(s);  \
  } \
  return r; \
}

#define AllFloatToIntegerRoundingConv(Ty,TySuf)  \
  FloatToIntegerRoundingConv(float,f32,Ty,TySuf,rte)  \
  FloatToIntegerRoundingConv(float,f32,Ty,TySuf,rtn)  \
  FloatToIntegerRoundingConv(float,f32,Ty,TySuf,rtp)  \
  FloatToIntegerRoundingConv(float,f32,Ty,TySuf,rtz)

#define AllFloatToIntegerSatRoundingConv(Ty,TySuf,Min,Max)  \
  FloatToIntegerSatRoundingConv(float,f32,Ty,TySuf,rte,Min,Max)  \
  FloatToIntegerSatRoundingConv(float,f32,Ty,TySuf,rtn,Min,Max)  \
  FloatToIntegerSatRoundingConv(float,f32,Ty,TySuf,rtp,Min,Max)  \
  FloatToIntegerSatRoundingConv(float,f32,Ty,TySuf,rtz,Min,Max)

#define AllFloatToUnsignedSatRoundingConv(Ty,TySuf,Max)  \
  FloatToUnsignedSatRoundingConv(float,f32,Ty,TySuf,rte,Max)  \
  FloatToUnsignedSatRoundingConv(float,f32,Ty,TySuf,rtn,Max)  \
  FloatToUnsignedSatRoundingConv(float,f32,Ty,TySuf,rtp,Max)  \
  FloatToUnsignedSatRoundingConv(float,f32,Ty,TySuf,rtz,Max)  

#define AllDoubleToIntegerRoundingConv(Ty,TySuf)  \
  FloatToIntegerRoundingConv(double,f64,Ty,TySuf,rte)  \
  FloatToIntegerRoundingConv(double,f64,Ty,TySuf,rtn)  \
  FloatToIntegerRoundingConv(double,f64,Ty,TySuf,rtp)  \
  FloatToIntegerRoundingConv(double,f64,Ty,TySuf,rtz)

#define AllDoubleToIntegerSatRoundingConv(Ty,TySuf,Min,Max)  \
  FloatToIntegerSatRoundingConv(double,f64,Ty,TySuf,rte,Min,Max)  \
  FloatToIntegerSatRoundingConv(double,f64,Ty,TySuf,rtn,Min,Max)  \
  FloatToIntegerSatRoundingConv(double,f64,Ty,TySuf,rtp,Min,Max)  \
  FloatToIntegerSatRoundingConv(double,f64,Ty,TySuf,rtz,Min,Max)

#define AllDoubleToUnsignedSatRoundingConv(Ty,TySuf,Max)  \
  FloatToUnsignedSatRoundingConv(double,f64,Ty,TySuf,rte,Max)  \
  FloatToUnsignedSatRoundingConv(double,f64,Ty,TySuf,rtn,Max)  \
  FloatToUnsignedSatRoundingConv(double,f64,Ty,TySuf,rtp,Max)  \
  FloatToUnsignedSatRoundingConv(double,f64,Ty,TySuf,rtz,Max)  

#define FloatingPointRoundingConv(FromTy,FromSuf,ToTy,ToSuf,Rnd)  \
__attribute__((always_inline)) ToTy \
__convert_##ToTy##_##Rnd##_##FromSuf(FromTy x) { \
  return (ToTy)__cvt_##ToSuf##_##Rnd##_##FromSuf(x);  \
}

#define AllIntegerToFloatRoundingConv(Ty,TySuf)  \
  FloatingPointRoundingConv(Ty,TySuf,float,f32,rtn)  \
  FloatingPointRoundingConv(Ty,TySuf,float,f32,rtp)  \
  FloatingPointRoundingConv(Ty,TySuf,float,f32,rtz)

#define AllIntegerToDoubleRoundingConv(Ty,TySuf)  \
  FloatingPointRoundingConv(Ty,TySuf,double,f64,rtn)  \
  FloatingPointRoundingConv(Ty,TySuf,double,f64,rtp)  \
  FloatingPointRoundingConv(Ty,TySuf,double,f64,rtz)

// Prototypes for conversion intrinsics

// float to integer conversion intrinsics
ConvIntrinPrototypeSet(float,f32,int,s32)
ConvIntrinPrototypeSet(float,f32,uint,u32)
ConvIntrinPrototypeSet(float,f32,long,s64)
ConvIntrinPrototypeSet(float,f32,ulong,u64)

// double to integer conversion intrinsics
ConvIntrinPrototypeSet(double,f64,int,s32)
ConvIntrinPrototypeSet(double,f64,uint,u32)
ConvIntrinPrototypeSet(double,f64,long,s64)
ConvIntrinPrototypeSet(double,f64,ulong,u64)

// integer to float conversion intrinsics
ConvIntrinPrototypeSet(int,i32,float,f32)
ConvIntrinPrototypeSet(uint,u32,float,f32)
ConvIntrinPrototypeSet(long,i64,float,f32)
ConvIntrinPrototypeSet(ulong,u64,float,f32)

// long to double conversion intrinsics
ConvIntrinPrototypeSet(long,i64,double,f64)
ConvIntrinPrototypeSet(ulong,u64,double,f64)

// double to float conversion intrinsics
ConvIntrinPrototypeSet(double,f64,float,f32)

// Defintions for conversion functions

// float to integer conversions
AllFloatToIntegerRoundingConv(char,s32)
AllFloatToIntegerRoundingConv(short,s32)
AllFloatToIntegerRoundingConv(int,s32)
AllFloatToIntegerRoundingConv(long,s64)

AllFloatToIntegerRoundingConv(uchar,u32)
AllFloatToIntegerRoundingConv(ushort,u32)
AllFloatToIntegerRoundingConv(uint,u32)
AllFloatToIntegerRoundingConv(ulong,u64)

AllFloatToIntegerSatRoundingConv(char,s32,CHAR_MIN,CHAR_MAX)
AllFloatToIntegerSatRoundingConv(short,s32,SHRT_MIN,SHRT_MAX)
AllFloatToIntegerSatRoundingConv(int,s32,INT_MIN,INT_MAX)
AllFloatToIntegerSatRoundingConv(long,s64,LONG_MIN,LONG_MAX)

AllFloatToUnsignedSatRoundingConv(uchar,u32,UCHAR_MAX)
AllFloatToUnsignedSatRoundingConv(ushort,u32,USHRT_MAX)
AllFloatToUnsignedSatRoundingConv(uint,u32,UINT_MAX)
AllFloatToUnsignedSatRoundingConv(ulong,u64,ULONG_MAX)

// double to integer conversions
AllDoubleToIntegerRoundingConv(char,s32)
AllDoubleToIntegerRoundingConv(short,s32)
AllDoubleToIntegerRoundingConv(int,s32)
AllDoubleToIntegerRoundingConv(long,s64)

AllDoubleToIntegerRoundingConv(uchar,u32)
AllDoubleToIntegerRoundingConv(ushort,u32)
AllDoubleToIntegerRoundingConv(uint,u32)
AllDoubleToIntegerRoundingConv(ulong,u64)

AllDoubleToIntegerSatRoundingConv(char,s32,CHAR_MIN,CHAR_MAX)
AllDoubleToIntegerSatRoundingConv(short,s32,SHRT_MIN,SHRT_MAX)
AllDoubleToIntegerSatRoundingConv(int,s32,INT_MIN,INT_MAX)
AllDoubleToIntegerSatRoundingConv(long,s64,LONG_MIN,LONG_MAX)

AllDoubleToUnsignedSatRoundingConv(uchar,u32,UCHAR_MAX)
AllDoubleToUnsignedSatRoundingConv(ushort,u32,USHRT_MAX)
AllDoubleToUnsignedSatRoundingConv(uint,u32,UINT_MAX)
AllDoubleToUnsignedSatRoundingConv(ulong,u64,ULONG_MAX)

// integer to float
AllIntegerToFloatRoundingConv(int,i32)
AllIntegerToFloatRoundingConv(uint,u32)
AllIntegerToFloatRoundingConv(long,i64)
AllIntegerToFloatRoundingConv(ulong,u64)

// long/ulong to double
AllIntegerToDoubleRoundingConv(long,i64)
AllIntegerToDoubleRoundingConv(ulong,u64)

// double to float conversions
FloatingPointRoundingConv(double,f64,float,f32,rtn)
FloatingPointRoundingConv(double,f64,float,f32,rtp)
FloatingPointRoundingConv(double,f64,float,f32,rtz)
