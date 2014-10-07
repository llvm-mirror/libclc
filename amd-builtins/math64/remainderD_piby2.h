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

// Reduction for medium sized arguments
static inline void
remainder_piby2_medium(double x, double *r, double *rr, int *regn)
{
    // How many pi/2 is x a multiple of?
    const double two_by_pi = 0x1.45f306dc9c883p-1;
    double dnpi2 = trunc(fma(x, two_by_pi, 0.5));

    const double piby2_h = -7074237752028440.0 / 0x1.0p+52;
    const double piby2_m = -2483878800010755.0 / 0x1.0p+105;
    const double piby2_t = -3956492004828932.0 / 0x1.0p+158;

    // Compute product of npi2 with 159 bits of 2/pi
    double p_hh = piby2_h * dnpi2;
    double p_ht = fma(piby2_h, dnpi2, -p_hh);
    double p_mh = piby2_m * dnpi2;
    double p_mt = fma(piby2_m, dnpi2, -p_mh);
    double p_th = piby2_t * dnpi2;
    double p_tt = fma(piby2_t, dnpi2, -p_th);

    // Reduce to 159 bits
    double ph = p_hh;
    double pm = p_ht + p_mh;
    double t = p_mh - (pm - p_ht);
    double pt = p_th + t + p_mt + p_tt;
    t = ph + pm; pm = pm - (t - ph); ph = t;
    t = pm + pt; pt = pt - (t - pm); pm = t;

    // Subtract from x
    t = x + ph;
    double qh = t + pm;
    double qt = pm - (qh - t) + pt;

    *r = qh;
    *rr = qt;
    *regn = (int)(long)dnpi2 & 0x3;
}

// Given positive argument x, reduce it to the range [-pi/4,pi/4] using
// extra precision, and return the result in r, rr.
// Return value "regn" tells how many lots of pi/2 were subtracted
// from x to put it in the range [-pi/4,pi/4], mod 4.

// For bytealign
#pragma OPENCL EXTENSION cl_amd_media_ops : enable

static inline void
remainder_piby2_large(double x, double *r, double *rr, int *regn)
{
    USE_TABLE(uchar, pibits, PIBITS);

    long ux = as_long(x);
    int e = (int)(ux >> 52) -  1023;
    int i = max(23, (e >> 3) + 17);
    int j = 150 - i;
    int j16 = j & ~0xf;

    // The following extracts 192 consecutive bits of 2/pi aligned on an arbitrary byte boundary
    uint4 q0 = *(__constant uint4 *)(pibits + j16);
    uint4 q1 = *(__constant uint4 *)(pibits + j16 + 16);
    uint4 q2 = *(__constant uint4 *)(pibits + j16 + 32);

    int k = (j >> 2) & 0x3;
    int4 c = (int4)k == (int4)(0, 1, 2, 3);

    uint u0, u1, u2, u3, u4, u5, u6;

    u0 = c.s1 ? q0.s1 : q0.s0;
    u0 = c.s2 ? q0.s2 : u0;
    u0 = c.s3 ? q0.s3 : u0;

    u1 = c.s1 ? q0.s2 : q0.s1;
    u1 = c.s2 ? q0.s3 : u1;
    u1 = c.s3 ? q1.s0 : u1;

    u2 = c.s1 ? q0.s3 : q0.s2;
    u2 = c.s2 ? q1.s0 : u2;
    u2 = c.s3 ? q1.s1 : u2;

    u3 = c.s1 ? q1.s0 : q0.s3;
    u3 = c.s2 ? q1.s1 : u3;
    u3 = c.s3 ? q1.s2 : u3;

    u4 = c.s1 ? q1.s1 : q1.s0;
    u4 = c.s2 ? q1.s2 : u4;
    u4 = c.s3 ? q1.s3 : u4;

    u5 = c.s1 ? q1.s2 : q1.s1;
    u5 = c.s2 ? q1.s3 : u5;
    u5 = c.s3 ? q2.s0 : u5;

    u6 = c.s1 ? q1.s3 : q1.s2;
    u6 = c.s2 ? q2.s0 : u6;
    u6 = c.s3 ? q2.s1 : u6;

    uint v0 = amd_bytealign(u1, u0, j);
    uint v1 = amd_bytealign(u2, u1, j);
    uint v2 = amd_bytealign(u3, u2, j);
    uint v3 = amd_bytealign(u4, u3, j);
    uint v4 = amd_bytealign(u5, u4, j);
    uint v5 = amd_bytealign(u6, u5, j);

    // Place those 192 bits in 4 48-bit doubles along with correct exponent
    // If i > 1018 we would get subnormals so we scale p up and x down to get the same product
    i = 2 + 8*i;
    x *= i > 1018 ? 0x1.0p-136 : 1.0;
    i -= i > 1018 ? 136 : 0;

    uint ua = (uint)(1023 + 52 - i) << 20;
    double a = as_double((uint2)(0, ua));
    double p0 = as_double((uint2)(v0, ua | (v1 & 0xffffU))) - a;
    ua += 0x03000000U;
    a = as_double((uint2)(0, ua));
    double p1 = as_double((uint2)((v2 << 16) | (v1 >> 16), ua | (v2 >> 16))) - a;
    ua += 0x03000000U;
    a = as_double((uint2)(0, ua));
    double p2 = as_double((uint2)(v3, ua | (v4 & 0xffffU))) - a;
    ua += 0x03000000U;
    a = as_double((uint2)(0, ua));
    double p3 = as_double((uint2)((v5 << 16) | (v4 >> 16), ua | (v5 >> 16))) - a;

    // Exact multiply
    double f0h = p0 * x;
    double f0l = fma(p0, x, -f0h);
    double f1h = p1 * x;
    double f1l = fma(p1, x, -f1h);
    double f2h = p2 * x;
    double f2l = fma(p2, x, -f2h);
    double f3h = p3 * x;
    double f3l = fma(p3, x, -f3h);

    // Accumulate product into 4 doubles
    double s, t;

    double f3 = f3h + f2h;
    t = f2h - (f3 - f3h);
    s = f3l + t;
    t = t - (s - f3l);

    double f2 = s + f1h;
    t = f1h - (f2 - s) + t;
    s = f2l + t;
    t = t - (s - f2l);

    double f1 = s + f0h;
    t = f0h - (f1 - s) + t;
    s = f1l + t;

    double f0 = s + f0l;

    // Strip off unwanted large integer bits
    f3 = 0x1.0p+10 * __amdil_fraction_f64(f3 * 0x1.0p-10);
    f3 += f3 + f2 < 0.0 ? 0x1.0p+10 : 0.0;

#undef EXTRA_ACCURACY
#if defined EXTRA_ACCURACY
    // Shift out large integer bits.  This adds about 20 bits to the accuracy of "rr"
    s = f3 + f2; t = f2 - (s - f3); f3 = s; f2 = t;
    s = f2 + f1; t = f1 - (s - f2); f2 = s; f1 = t;
    s = f1 + f0; t = f0 - (s - f1); f1 = s; f0 = t;
#endif

    // Compute least significant integer bits
    t = f3 + f2;
    double di = t - __amdil_fraction_f64(t);
    i = (float)di;

    // Shift out remaining integer part
    f3 -= di;
    s = f3 + f2; t = f2 - (s - f3); f3 = s; f2 = t;
    s = f2 + f1; t = f1 - (s - f2); f2 = s; f1 = t;
    f1 += f0;

    // Subtract 1 if fraction is >= 0.5, and update regn
    int g = f3 >= 0.5;
    i += g;
    f3 -= (float)g;

    // Shift up bits
    s = f3 + f2; t = f2 -(s - f3); f3 = s; f2 = t + f1;

    // Multiply precise fraction by pi/2 to get radians
    const double p2h = 7074237752028440.0 / 0x1.0p+52;
    const double p2t = 4967757600021510.0 / 0x1.0p+106;

    double rhi = f3 * p2h;
    double rlo = fma(f2, p2h, fma(f3, p2t, fma(f3, p2h, -rhi)));

    *r = rhi + rlo;
    *rr = rlo - (*r - rhi);
    *regn = i & 0x3;
}

