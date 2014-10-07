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

/*
 * ====================================================
 * Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
 *
 * Developed at SunPro, a Sun Microsystems, Inc. business.
 * Permission to use, copy, modify, and distribute this
 * software is freely granted, provided that this notice
 * is preserved.
 * ====================================================
 */

#define pi   3.1415927410e+00f        /* 0x40490fdb */

#define a0   7.7215664089e-02f        /* 0x3d9e233f */
#define a1   3.2246702909e-01f        /* 0x3ea51a66 */
#define a2   6.7352302372e-02f        /* 0x3d89f001 */
#define a3   2.0580807701e-02f        /* 0x3ca89915 */
#define a4   7.3855509982e-03f        /* 0x3bf2027e */
#define a5   2.8905137442e-03f        /* 0x3b3d6ec6 */
#define a6   1.1927076848e-03f        /* 0x3a9c54a1 */
#define a7   5.1006977446e-04f        /* 0x3a05b634 */
#define a8   2.2086278477e-04f        /* 0x39679767 */
#define a9   1.0801156895e-04f        /* 0x38e28445 */
#define a10  2.5214456400e-05f        /* 0x37d383a2 */
#define a11  4.4864096708e-05f        /* 0x383c2c75 */

#define tc   1.4616321325e+00f        /* 0x3fbb16c3 */

#define tf  -1.2148628384e-01f        /* 0xbdf8cdcd */
/* tt -(tail of tf) */
#define tt   6.6971006518e-09f        /* 0x31e61c52 */

#define t0   4.8383611441e-01f        /* 0x3ef7b95e */
#define t1  -1.4758771658e-01f        /* 0xbe17213c */
#define t2   6.4624942839e-02f        /* 0x3d845a15 */
#define t3  -3.2788541168e-02f        /* 0xbd064d47 */
#define t4   1.7970675603e-02f        /* 0x3c93373d */
#define t5  -1.0314224288e-02f        /* 0xbc28fcfe */
#define t6   6.1005386524e-03f        /* 0x3bc7e707 */
#define t7  -3.6845202558e-03f        /* 0xbb7177fe */
#define t8   2.2596477065e-03f        /* 0x3b141699 */
#define t9  -1.4034647029e-03f        /* 0xbab7f476 */
#define t10  8.8108185446e-04f        /* 0x3a66f867 */
#define t11 -5.3859531181e-04f        /* 0xba0d3085 */
#define t12  3.1563205994e-04f        /* 0x39a57b6b */
#define t13 -3.1275415677e-04f        /* 0xb9a3f927 */
#define t14  3.3552918467e-04f        /* 0x39afe9f7 */

#define u0  -7.7215664089e-02f        /* 0xbd9e233f */
#define u1   6.3282704353e-01f        /* 0x3f2200f4 */
#define u2   1.4549225569e+00f        /* 0x3fba3ae7 */
#define u3   9.7771751881e-01f        /* 0x3f7a4bb2 */
#define u4   2.2896373272e-01f        /* 0x3e6a7578 */
#define u5   1.3381091878e-02f        /* 0x3c5b3c5e */

#define v1   2.4559779167e+00f        /* 0x401d2ebe */
#define v2   2.1284897327e+00f        /* 0x4008392d */
#define v3   7.6928514242e-01f        /* 0x3f44efdf */
#define v4   1.0422264785e-01f        /* 0x3dd572af */
#define v5   3.2170924824e-03f        /* 0x3b52d5db */

#define s0  -7.7215664089e-02f        /* 0xbd9e233f */
#define s1   2.1498242021e-01f        /* 0x3e5c245a */
#define s2   3.2577878237e-01f        /* 0x3ea6cc7a */
#define s3   1.4635047317e-01f        /* 0x3e15dce6 */
#define s4   2.6642270386e-02f        /* 0x3cda40e4 */
#define s5   1.8402845599e-03f        /* 0x3af135b4 */
#define s6   3.1947532989e-05f        /* 0x3805ff67 */

#define r1   1.3920053244e+00f        /* 0x3fb22d3b */
#define r2   7.2193557024e-01f        /* 0x3f38d0c5 */
#define r3   1.7193385959e-01f        /* 0x3e300f6e */
#define r4   1.8645919859e-02f        /* 0x3c98bf54 */
#define r5   7.7794247773e-04f        /* 0x3a4beed6 */
#define r6   7.3266842264e-06f        /* 0x36f5d7bd */

#define w0   4.1893854737e-01f        /* 0x3ed67f1d */
#define w1   8.3333335817e-02f        /* 0x3daaaaab */
#define w2  -2.7777778450e-03f        /* 0xbb360b61 */
#define w3   7.9365057172e-04f        /* 0x3a500cfd */
#define w4  -5.9518753551e-04f        /* 0xba1c065c */
#define w5   8.3633989561e-04f        /* 0x3a5b3dd2 */
#define w6  -1.6309292987e-03f        /* 0xbad5c4e8 */

__attribute__ ((overloadable, always_inline)) float
lgamma_r(float x, int *signp)
{
    int hx = as_int(x);
    int ix = hx & 0x7fffffff;
    float absx = as_float(ix);

    if (ix >= 0x7f800000) {
	*signp = 1;
        return x;
    }

    if (absx < 0x1.0p-70f) {
        *signp = hx < 0 ? -1 : 1;
	return -log(absx);
    }

    float r;

    if (absx == 1.0f | absx == 2.0f)
        r = 0.0f;

    else if (absx < 2.0f) {
	float y = 2.0f - absx;
	int i = 0;

	int c = absx < 0x1.bb4c30p+0f;
	float yt = absx - tc;
	y = c ? yt : y;
	i = c ? 1 : i;

	c = absx < 0x1.3b4c40p+0f;
	yt = absx - 1.0f;
	y = c ? yt : y;
	i = c ? 2 : i;

	r = -log(absx);
	yt = 1.0f - absx;
	c = absx <= 0x1.ccccccp-1f;
	r = c ? r : 0.0f;
	y = c ? yt : y;
	i = c ? 0 : i;

	c = absx < 0x1.769440p-1f;
	yt = absx - (tc - 1.0f);
	y = c ? yt : y;
	i = c ? 1 : i;

	c = absx < 0x1.da6610p-3f;
	y = c ? absx : y;
	i = c ? 2 : i;

	float z, w, p1, p2, p3, p;
        switch (i) {
        case 0:
            z = y * y;
	    p1 = mad(z, mad(z, mad(z, mad(z, mad(z, a10, a8), a6), a4), a2), a0);
	    p2 = z * mad(z, mad(z, mad(z, mad(z, mad(z, a11, a9), a7), a5), a3), a1);
	    p = mad(y, p1, p2);
	    r += mad(y, -0.5f, p);
            break;
        case 1:
            z = y * y;
            w = z * y;
	    p1 = mad(w, mad(w, mad(w, mad(w, t12, t9), t6), t3), t0);
	    p2 = mad(w, mad(w, mad(w, mad(w, t13, t10), t7), t4), t1);
            p3 = mad(w, mad(w, mad(w, mad(w, t14, t11), t8), t5), t2);
            p = mad(z, p1, -mad(w, -mad(y, p3, p2), tt));
            r += tf + p;
            break;
        case 2:
            p1 = y * mad(y, mad(y, mad(y, mad(y, mad(y, u5, u4), u3), u2), u1), u0);
            p2 = mad(y, mad(y, mad(y, mad(y, mad(y, v5, v4), v3), v2), v1), 1.0f);
            r += mad(y, -0.5f, MATH_DIVIDE(p1, p2));
	    break;
        }
    } else if (absx < 8.0f) {
        int i = (int)absx;
        float y = absx - (float) i;
        float p = y * mad(y, mad(y, mad(y, mad(y, mad(y, mad(y, s6, s5), s4), s3), s2), s1), s0);
        float q = mad(y, mad(y, mad(y, mad(y, mad(y, mad(y, r6, r5), r4), r3), r2), r1), 1.0f);
        r = mad(y, 0.5f, MATH_DIVIDE(p, q));

	float y6 = y + 6.0f;
	float y5 = y + 5.0f;
	float y4 = y + 4.0f;
	float y3 = y + 3.0f;
	float y2 = y + 2.0f;

        float z = 1.0f;
	z *= i > 6 ? y6 : 1.0f;
	z *= i > 5 ? y5 : 1.0f;
	z *= i > 4 ? y4 : 1.0f;
	z *= i > 3 ? y3 : 1.0f;
	z *= i > 2 ? y2 : 1.0f;

        r += log(z);
    } else if (absx < 0x1.0p+58f) {
        float z = 1.0f / absx;
        float y = z * z;
        float w = mad(z, mad(y, mad(y, mad(y, mad(y, mad(y, w6, w5), w4), w3), w2), w1), w0);
	r = mad(absx - 0.5f, log(absx) - 1.0f, w);
    } else
        // 2**58 <= x <= Inf
        r = absx * (log(absx) - 1.0f);

    int s = 1;

    if (x < 0.0f) {
        float t = sinpi(x);
        r = log(pi / fabs(t * x)) - r;
	r = t == 0.0f ? as_float(PINFBITPATT_SP32) : r;
	s = t < 0.0f ? -1 : s;
    }

    *signp = s;
    return r;
}

#if __OPENCL_C_VERSION__ < 200
__attribute__ ((overloadable, always_inline)) float
lgamma_r(float x, __local int *signp)
{
    int s;
    float l = lgamma_r(x, &s);
    *signp = s;
    return l;
}

__attribute__ ((overloadable, always_inline)) float
lgamma_r(float x, __global int *signp)
{
    int s;
    float l = lgamma_r(x, &s);
    *signp = s;
    return l;
}
#endif

__attribute__ ((overloadable, always_inline)) float
lgamma(float x)
{
    int s;
    float l = lgamma_r(x, &s);
    return l;
}

