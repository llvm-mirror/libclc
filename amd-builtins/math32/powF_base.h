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

// compute pow using log and exp
// x^y = exp(y * log(x))
//
// we take care not to lose precision in the intermediate steps
//
// When computing log, calculate it in splits,
//
// r = f * (p_invead + p_inv_tail)
// r = rh + rt
//
// calculate log polynomial using r, in end addition, do
// poly = poly + ((rh-r) + rt)
//
// lth = -r
// ltt = ((xexp * log2_t) - poly) + logT
// lt = lth + ltt
//
// lh = (xexp * log2_h) + logH
// l = lh + lt
//
// Calculate final log answer as gh and gt,
// gh = l & higher-half bits
// gt = (((ltt - (lt - lth)) + ((lh - l) + lt)) + (l - gh))
//
// yh = y & higher-half bits
// yt = y - yh
//
// Before entering computation of exp,
// vs = ((yt*gt + yt*gh) + yh*gt)
// v = vs + yh*gh
// vt = ((yh*gh - v) + vs)
//
// In calculation of exp, add vt to r that is used for poly
// At the end of exp, do
// ((((expT * poly) + expT) + expH*poly) + expH)

__attribute__((overloadable)) float
#if defined(COMPILING_POWR)
powr(float x, float y)
#elif defined(COMPILING_POWN)
pown(float x, int ny)
#elif defined(COMPILING_ROOTN)
rootn(float x, int ny)
#else
pow(float x, float y)
#endif
{
    USE_TABLE(float2, p_log, LOGE_TBL);
    USE_TABLE(float2, p_inv, LOG_INV_TBL_EP);
    USE_TABLE(float2, p_jby64, EXP_TBL_EP);

#if defined(COMPILING_POWN)
    float y = (float)ny;
#elif defined(COMPILING_ROOTN)
    float y = MATH_RECIP((float)ny);
#endif

    int ix = as_int(x);
    int ax = ix & EXSIGNBIT_SP32;
    int xpos = ix == ax;

    int iy = as_int(y);
    int ay = iy & EXSIGNBIT_SP32;
    int ypos = iy == ay;

    // Extra precise log calculation
    // First handle case that x is close to 1
    float r = 1.0f - as_float(ax);
    int near1 = fabs(r) < 0x1.0p-4f;
    float r2 = r*r;

    // Coefficients are just 1/3, 1/4, 1/5 and 1/6
    float poly = mad(r,
                     mad(r,
                         mad(r,
                             mad(r, 0x1.24924ap-3f, 0x1.555556p-3f),
                             0x1.99999ap-3f),
                         0x1.000000p-2f),
                     0x1.555556p-2f);

    poly *= r2*r;

    float lth_near1 = -r2 * 0.5f;
    float ltt_near1 = -poly;
    float lt_near1 = lth_near1 + ltt_near1;
    float lh_near1 = -r;
    float l_near1 = lh_near1 + lt_near1;

    // Computations for x not near 1
    int m = (int)(ax >> EXPSHIFTBITS_SP32) - EXPBIAS_SP32;
    float mf = (float)m;
    int ixs = as_int(as_float(ax | 0x3f800000) - 1.0f);
    float mfs = (float)((ixs >> EXPSHIFTBITS_SP32) - 253);
    int c = m == -127;
    int ixn = c ? ixs : ax;
    float mfn = c ? mfs : mf;

    int indx = (ixn & 0x007f0000) + ((ixn & 0x00008000) << 1);

    // F - Y
    float f = as_float(0x3f000000 | indx) - as_float(0x3f000000 | (ixn & MANTBITS_SP32));

    indx = indx >> 16;
    float2 tv = p_inv[indx];
    float rh = f * tv.s0;
    float rt = f * tv.s1;
    r = rh + rt;

    poly = mad(r, mad(r, 0x1.0p-2f, 0x1.555556p-2f), 0x1.0p-1f) * (r*r);
    poly += (rh - r) + rt;

    const float LOG2_HEAD = 0x1.62e000p-1f;  // 0.693115234
    const float LOG2_TAIL = 0x1.0bfbe8p-15f; // 0.0000319461833
    tv = p_log[indx];
    float lth = -r;
    float ltt = mad(mfn, LOG2_TAIL, -poly) + tv.s1;
    float lt = lth + ltt;
    float lh = mad(mfn, LOG2_HEAD, tv.s0);
    float l = lh + lt;

    // Select near 1 or not
    lth = near1 ? lth_near1 : lth;
    ltt = near1 ? ltt_near1 : ltt;
    lt = near1 ? lt_near1 : lt;
    lh = near1 ? lh_near1 : lh;
    l = near1 ? l_near1 : l;

    float gh = as_float(as_int(l) & 0xfffff000);
    float gt = ((ltt - (lt - lth)) + ((lh - l) + lt)) + (l - gh);

    float yh = as_float(iy & 0xfffff000);

#if defined(COMPILING_POWN)
    float yt = (float)(ny - (int)yh);
#elif defined(COMPILING_ROOTN)
    float fny = (float)ny;
    float fnyh = as_float(as_int(fny) & 0xfffff000);
    float fnyt = (float)(ny - (int)fnyh);
    float yt = MATH_DIVIDE(mad(-fnyt, yh, mad(-fnyh, yh, 1.0f)), fny);
#else
    float yt = y - yh;
#endif

    float ylogx_s = mad(gt, yh, mad(gh, yt, yt*gt));
    float ylogx = mad(yh, gh, ylogx_s);
    float ylogx_t = mad(yh, gh, -ylogx) + ylogx_s;

    // Extra precise exp of ylogx
    const float R_64_BY_LOG2 = 0x1.715476p+6f; // 64/log2 : 92.332482616893657
    int n = convert_int(ylogx * R_64_BY_LOG2);
    float nf = (float) n;

    int j = n & 0x3f;
    m = n >> 6;
    int m2 = m << EXPSHIFTBITS_SP32;

    const float R_LOG2_BY_64_LD = 0x1.620000p-7f;  // log2/64 lead: 0.0108032227
    const float R_LOG2_BY_64_TL = 0x1.c85fdep-16f; // log2/64 tail: 0.0000272020388
    r = mad(nf, -R_LOG2_BY_64_TL, mad(nf, -R_LOG2_BY_64_LD, ylogx)) + ylogx_t;

    // Truncated Taylor series for e^r
    poly = mad(mad(mad(r, 0x1.555556p-5f, 0x1.555556p-3f), r, 0x1.000000p-1f), r*r, r);

    tv = p_jby64[j];

    float expylogx = mad(tv.s0, poly, mad(tv.s1, poly, tv.s1)) + tv.s0;
    #if !defined(SUBNORMALS_SUPPORTED)
		int explg = ((as_uint(expylogx) & EXPBITS_SP32 >> 23) - 127);
		m = (23-(m + 149)) == 0 ? 1: m;
		uint mantissa =  ((as_uint(expylogx) & MANTBITS_SP32)|IMPBIT_SP32) >> (23-(m + 149));
 		float sexpylogx = as_float(mantissa);
    #else
    	float sexpylogx = expylogx * as_float(0x1 << (m + 149));
    #endif


    float texpylogx = as_float(as_int(expylogx) + m2);
    expylogx = m < -125 ? sexpylogx : texpylogx;

    // Result is +-Inf if (ylogx + ylogx_t) > 128*log2
    expylogx = ylogx > 0x1.62e430p+6f | (ylogx == 0x1.62e430p+6f & ylogx_t > -0x1.05c610p-22f) ? as_float(PINFBITPATT_SP32) : expylogx;

    // Result is 0 if ylogx < -149*log2
    expylogx = ylogx <  -0x1.9d1da0p+6f ? 0.0f : expylogx;

    // Classify y:
    //   inty = 0 means not an integer.
    //   inty = 1 means odd integer.
    //   inty = 2 means even integer.

#if defined(COMPILING_POWN) || defined(COMPILING_ROOTN)
    int inty = 2 - (ny & 1);
#else
    int yexp = (int)(ay >> EXPSHIFTBITS_SP32) - EXPBIAS_SP32 + 1;
    int mask = (1 << (24 - yexp)) - 1;
    int yodd = ((iy >> (24 - yexp)) & 0x1) != 0;
    int inty = yodd ? 1 : 2;
    inty = (iy & mask) != 0 ? 0 : inty;
    inty = yexp < 1 ? 0 : inty;
    inty = yexp > 24 ? 2 : inty;
#endif

	float signval = as_float((as_uint(expylogx) ^ SIGNBIT_SP32));
	expylogx = (inty == 1 & !xpos) ? signval : expylogx;
    int ret = as_int(expylogx);

    // Corner case handling

#if defined COMPILING_POWR
    ret = ax < 0x3f800000 & iy == NINFBITPATT_SP32 ? PINFBITPATT_SP32 : ret;
    ret = ax < 0x3f800000 & iy == PINFBITPATT_SP32 ? 0 : ret;
    ret = ax == 0x3f800000 & ay < PINFBITPATT_SP32 ? 0x3f800000 : ret;
    ret = ax == 0x3f800000 & ay == PINFBITPATT_SP32 ? QNANBITPATT_SP32 : ret;
    ret = ax > 0x3f800000 & iy == NINFBITPATT_SP32 ? 0 : ret;
    ret = ax > 0x3f800000 & iy == PINFBITPATT_SP32 ? PINFBITPATT_SP32 : ret;
    ret = ix < PINFBITPATT_SP32 & ay == 0 ? 0x3f800000 : ret;
    ret = ax == PINFBITPATT_SP32 & !ypos ? 0 : ret;
    ret = ax == PINFBITPATT_SP32 & ypos ? PINFBITPATT_SP32 : ret;
    ret = ax == PINFBITPATT_SP32 & iy == PINFBITPATT_SP32 ? PINFBITPATT_SP32 : ret;
    ret = ax == PINFBITPATT_SP32 & ay == 0 ? QNANBITPATT_SP32 : ret;
    ret = ax == 0 & !ypos ? PINFBITPATT_SP32 : ret;
    ret = ax == 0 & ypos ? 0 : ret;
    ret = ax == 0 & ay == 0 ? QNANBITPATT_SP32 : ret;
    ret = ax != 0 & !xpos ? QNANBITPATT_SP32 : ret;
    ret = ax > PINFBITPATT_SP32 ? ix : ret;
    ret = ay > PINFBITPATT_SP32 ? iy : ret;
#elif defined COMPILING_POWN
    int xinf = xpos ? PINFBITPATT_SP32 : NINFBITPATT_SP32;
    ret = ax == 0 & !ypos & inty == 1 ? xinf : ret;
    ret = ax == 0 & !ypos & inty == 2 ? PINFBITPATT_SP32 : ret;
    ret = ax == 0 & ypos & inty == 2 ? 0 : ret;
    int xzero = !xpos ? 0x80000000 : 0L;
    ret = ax == 0 & ypos & inty == 1 ? xzero : ret;
    ret = ix == NINFBITPATT_SP32 & !ypos & inty == 1 ? 0x80000000 : ret;
    ret = ix == NINFBITPATT_SP32 & !ypos & inty != 1 ? 0 : ret;
    ret = ix == NINFBITPATT_SP32 & ypos & inty == 1 ? NINFBITPATT_SP32 : ret;
    ret = ix == NINFBITPATT_SP32 & ypos & inty != 1 ? PINFBITPATT_SP32 : ret;
    ret = ix == PINFBITPATT_SP32 & !ypos ? 0 : ret;
    ret = ix == PINFBITPATT_SP32 & ypos ? PINFBITPATT_SP32 : ret;
    ret = ax > PINFBITPATT_SP32 ? ix : ret;
    ret = ny == 0 ? 0x3f800000 : ret;
#elif defined COMPILING_ROOTN
    ret = !xpos & inty == 2 ? QNANBITPATT_SP32 : ret;
    int xinf = xpos ? PINFBITPATT_SP32 : NINFBITPATT_SP32;
    ret = ax == 0 & !ypos & inty == 1 ? xinf : ret;
    ret = ax == 0 & !ypos & inty == 2 ? PINFBITPATT_SP32 : ret;
    ret = ax == 0 & ypos & inty == 2 ? 0 : ret;
    int xzero = xpos ? 0 : 0x80000000;
    ret = ax == 0 & ypos & inty == 1 ? xzero : ret;
    ret = ix == NINFBITPATT_SP32 & ypos & inty == 1 ? NINFBITPATT_SP32 : ret;
    ret = ix == NINFBITPATT_SP32 & !ypos & inty == 1 ? 0x80000000 : ret;
    ret = ix == PINFBITPATT_SP32 & !ypos ? 0 : ret;
    ret = ix == PINFBITPATT_SP32 & ypos ? PINFBITPATT_SP32 : ret;
    ret = ax > PINFBITPATT_SP32 ? ix : ret;
    ret = ny == 0 ? QNANBITPATT_SP32 : ret;
#else
    ret = !xpos & inty == 0 ? QNANBITPATT_SP32 : ret;
    ret = ax < 0x3f800000 & iy == NINFBITPATT_SP32 ? PINFBITPATT_SP32 : ret;
    ret = ax > 0x3f800000 & iy == NINFBITPATT_SP32 ? 0 : ret;
    ret = ax < 0x3f800000 & iy == PINFBITPATT_SP32 ? 0 : ret;
    ret = ax > 0x3f800000 & iy == PINFBITPATT_SP32 ? PINFBITPATT_SP32 : ret;
    int xinf = xpos ? PINFBITPATT_SP32 : NINFBITPATT_SP32;
    ret = ax == 0 & !ypos & inty == 1 ? xinf : ret;
    ret = ax == 0 & !ypos & inty != 1 ? PINFBITPATT_SP32 : ret;
    int xzero = xpos ? 0 : 0x80000000;
    ret = ax == 0 & ypos & inty == 1 ? xzero : ret;
    ret = ax == 0 & ypos & inty != 1 ? 0 : ret;
    ret = ax == 0 & iy == NINFBITPATT_SP32 ? PINFBITPATT_SP32 : ret;
    ret = ix == 0xbf800000 & ay == PINFBITPATT_SP32 ? 0x3f800000 : ret;
    ret = ix == NINFBITPATT_SP32 & !ypos & inty == 1 ? 0x80000000 : ret;
    ret = ix == NINFBITPATT_SP32 & !ypos & inty != 1 ? 0 : ret;
    ret = ix == NINFBITPATT_SP32 & ypos & inty == 1 ? NINFBITPATT_SP32 : ret;
    ret = ix == NINFBITPATT_SP32 & ypos & inty != 1 ? PINFBITPATT_SP32 : ret;
    ret = ix == PINFBITPATT_SP32 & !ypos ? 0 : ret;
    ret = ix == PINFBITPATT_SP32 & ypos ? PINFBITPATT_SP32 : ret;
    ret = ax > PINFBITPATT_SP32 ? ix : ret;
    ret = ay > PINFBITPATT_SP32 ? iy : ret;
    ret = ay == 0 ? 0x3f800000 : ret;
    ret = ix == 0x3f800000 ? 0x3f800000 : ret;
#endif

    return as_float(ret);
}

