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

#include "math32.h"

__attribute__((overloadable, always_inline)) float4
fma(float4 a, float4 b, float4 c)
{
    float4 ret;
    ret.lo = fma(a.lo, b.lo, c.lo);
    ret.hi = fma(a.hi, b.hi, c.hi);
    return ret;
}

__attribute__((overloadable, always_inline)) float2
fma(float2 a, float2 b, float2 c)
{
    float2 ret;
    ret.lo = fma(a.lo, b.lo, c.lo);
    ret.hi = fma(a.hi, b.hi, c.hi);
    return ret;
}

#define CM(C, B, A) as_float(__amdil_cmov_logical_i32(as_uint(C), as_uint(B), as_uint(A)))

__attribute__((overloadable, always_inline)) float
fma(float a, float b, float c)
{
    if (HAVE_HW_FMA32()) {
	return __amdil_fma_f32(a, b, c);
    } else {
        float z3 = mad(a, b, c);
        float cs = c;
    
        int ae = as_int(a) >> 23;
        int be = as_int(b) >> 23;
        int ce = as_int(c) >> 23;
    
        ae &= 0xff;
        be &= 0xff;
        ce &= 0xff;
    
        ae -= 127;
        be -= 127;
        ce -= 127;
    
        int pe = ae + be;
    
        int cen = ce - pe;
        cen += 127;
        cen <<= 23;
    
        // special cases flag
        int spclal = ae == -127;
        int spclbl = be == -127;
        int spclcl = ce == -127;
    
        int spclah = ae == 128;
        int spclbh = be == 128;
        int spclch = ce == 128;
    
        spclal |= spclah;
        spclbl |= spclbh;
        spclcl |= spclch;
    
        int spcl = spclal | spclbl;
        spcl |= spclcl;
    
        int spcl2 = spclah | spclbh;
        spcl2 = ~spcl2;
        spcl2 &= spclch;
    
        // Normalize
        int an = as_int(a) & 0x807fffff;
        int bn = as_int(b) & 0x807fffff;
        int cn = as_int(c) & 0x807fffff;
    
        an |= 0x3f800000;
        bn |= 0x3f800000;
        cn |= cen;
    
        a = as_float(an);
        b = as_float(bn);
        c = as_float(cn);
    
        // Get head & tail parts of a, b
        float ah = as_float(an & 0xfffff000);
        float bh = as_float(bn & 0xfffff000);
    
        float at = a - ah;
        float bt = b - bh;
    
        // Get head & tail parts of the product a*b
        float p = a * b;
        float pt = mad(ah, bh, -p);
        pt = mad(ah, bt, pt);
        pt = mad(at, bh, pt);
        pt = mad(at, bt, pt);
    
        // carefully add p and c; these steps valid only when pe and ce are not far apart
        float rr = p + c;
        float t1 = p - rr;
        t1 += c;
        float t2 = c - rr;
        t2 += p;
        int pick1 = as_int(p) & 0x7fffffff;
        int pick2 = as_int(c) & 0x7fffffff;
        int pick = pick1 > pick2;
        float t = CM(pick, t1, t2);
    
        float vv = t + pt;
        float ww1 = t - vv;
        ww1 += pt;
        float ww2 = pt - vv;
        ww2 += t;
        pick1 = as_int(t) & 0x7fffffff;
        pick2 = as_int(pt) & 0x7fffffff;
        pick = pick1 > pick2;
        float ww = CM(pick, ww1, ww2);
    
        // pick r,v,w based on how far apart pe and ce are
        // number 60 is safe; actual value close to 24+24+2
        pick1 = pe - ce;
        pick = pick1 < 60;
        float r = CM(pick, rr, p);
        float v = CM(pick, vv, pt);
        float w = CM(pick, ww, cs);
    
        // identify if there was a rounding issue, and so correction is needed
        int rndc1 = as_int(r) & 0x7f800000;
        int rndc2 = as_int(v) & 0x7f800000;
        int rndc = rndc1 - rndc2;
        rndc = rndc == 0x0c000000;
        rndc1 = as_int(v) & 0x007fffff;
        rndc1 = rndc1 == 0;
        rndc2 = as_int(w) & 0x7fffffff;
        rndc2 = rndc2 != 0;
        rndc &= rndc1;
        rndc &= rndc2;
    
        int ws = as_int(w) & 0x80000000;
        int ve = as_int(v) & 0x7f800000;
        ve -= 0x0b800000;
        w = as_float(ws | ve);
    
        float vw = v + w;
        v = CM(rndc, vw, v);
        float z = r + v;
    
        // reconstruct return value
        int ze = as_int(z) >> 23;
        ze &= 0xff;
        ze -= 127;
        ze += pe;
        ze += 127;
    
        int z1e = ze & 0xff;
        z1e <<= 23;
        int z1 = as_int(z) & 0x807fffff;
        z1 |= z1e;
    
        pick1 = as_int(z) & 0x7fffffff;
        pick = pick1 == 0;
        z = CM(pick, z, z1);
    
        int z2 = as_int(z) & 0x80000000;
        pick = ze <= 0;
        z = CM(pick, z2, z);
        z2 |=  0x7f800000;
        pick = ze > 254;
        z = CM(pick, z2, z);
    
        pick1 = ce - pe;
        pick = pick1 > 30;
        z = CM(pick, cs, z);
        z = CM(spcl, z3, z);
        z = CM(spcl2, cs, z);
        return z;
    }
}

