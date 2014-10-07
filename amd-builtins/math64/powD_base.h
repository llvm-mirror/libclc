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

#include "math64.h"

__attribute__((overloadable, always_inline, weak)) double
#if defined(COMPILING_POWR)
powr(double x, double y)
#elif defined(COMPILING_POWN)
pown(double x, int ny)
#elif defined(COMPILING_ROOTN)
rootn(double x, int ny)
#else
pow(double x, double y)
#endif
{
    const double real_log2_tail = 5.76999904754328540596e-08;
    const double real_log2_lead = 6.93147122859954833984e-01;

    USE_TABLE(double2, p_powlog_tbl, POWLOG_TBL);
    USE_TABLE(double2, p_log_F_inv_tbl, LOG_F_INV_TBL);
    USE_TABLE(double2, p_two_to, TWO_TO_JBY64_EP);

#if defined(COMPILING_POWN)
    double y = (double) ny;
#elif defined(COMPILING_ROOTN)
    double dny = (double)ny;
    double y = 1.0 / dny;
#endif

    long ux = as_long(x);
    long ax = ux & (~SIGNBIT_DP64);
    int xpos = ax == ux;

    long uy = as_long(y);
    long ay = uy & (~SIGNBIT_DP64);
    int ypos = ay == uy;

    // Extended precision log
    double v, vt;
    {
        int exp = (int)(ax >> 52) - 1023;
        int mask_exp_1023 = exp == -1023;
        double xexp = (double) exp;
        long mantissa = ax & 0x000FFFFFFFFFFFFFL;

        long temp_ux = as_long(as_double(0x3ff0000000000000L | mantissa) - 1.0);
        exp = ((temp_ux & 0x7FF0000000000000L) >> 52) - 2045;
        double xexp1 = (double) exp;
        long mantissa1 = temp_ux & 0x000FFFFFFFFFFFFFL;

        xexp = mask_exp_1023 ? xexp1 : xexp;
        mantissa = mask_exp_1023 ? mantissa1 : mantissa;

        long rax = (mantissa & 0x000ff00000000000) + ((mantissa & 0x0000080000000000) << 1);
        int index = rax >> 44;

        double F = as_double(rax | 0x3FE0000000000000L);
        double Y = as_double(mantissa | 0x3FE0000000000000L);
        double f = F - Y;
        double2 tv = p_log_F_inv_tbl[index];
        double log_h = tv.s0;
        double log_t = tv.s1;
        double f_inv = (log_h + log_t) * f;
        double r1 = as_double(as_long(f_inv) & 0xfffffffff8000000L);
        double r2 = fma(-F, r1, f) * (log_h + log_t);
        double r = r1 + r2;

        double poly = fma(r,
                          fma(r,
                              fma(r,
                                  fma(r, 1.0/7.0, 1.0/6.0),
                                  1.0/5.0),
                              1.0/4.0),
                          1.0/3.0);
        poly = poly * r * r * r;

        double hr1r1 = 0.5*r1*r1;
        double poly0h = r1 + hr1r1;
        double poly0t = r1 - poly0h + hr1r1;
	poly = fma(r1, r2, fma(0.5*r2, r2, poly)) + r2 + poly0t;

        tv = p_powlog_tbl[index];
        log_h = tv.s0;
        log_t = tv.s1;

        double resT_t = fma(xexp, real_log2_tail, + log_t) - poly;
        double resT = resT_t - poly0h;
        double resH = fma(xexp, real_log2_lead, log_h);
        double resT_h = poly0h;

        double H = resT + resH;
        double H_h = as_double(as_long(H) & 0xfffffffff8000000L);
        double T = (resH - H + resT) + (resT_t - (resT + resT_h)) + (H - H_h);
        H = H_h;

        double y_head = as_double(uy & 0xfffffffff8000000L);
        double y_tail = y - y_head;

#if defined(COMPILING_POWN)
        int mask_2_24 = ay > 0x4170000000000000; // 2^24
        int nyh = convert_int(y_head);
        int nyt = ny - nyh;
        double y_tail1 = (double)nyt;
        y_tail = mask_2_24 ? y_tail1 : y_tail;
#endif

#if defined(COMPILING_ROOTN)
        double fnyh = as_double(as_long(dny) & 0xfffffffffff00000);
        double fnyt = (double)(ny - (int)fnyh);
        y_tail = fma(-fnyt, y_head, fma(-fnyh, y_head, 1.0))/ dny;
#endif

        double temp = fma(y_tail, H, fma(y_head, T, y_tail*T));
        v = fma(y_head, H, temp);
        vt = fma(y_head, H, -v) + temp;
    }

    // Now calculate exp of (v,vt)

    double expv;
    {
        const double max_exp_arg = 709.782712893384;
        const double min_exp_arg = -745.1332191019411;
        const double sixtyfour_by_lnof2 = 92.33248261689366;
        const double lnof2_by_64_head = 0.010830424260348081;
        const double lnof2_by_64_tail = -4.359010638708991e-10;

        double temp = v * sixtyfour_by_lnof2;
        int n = (int)temp;
        double dn = (double)n;
        int j = n & 0x0000003f;
        int m = n >> 6;

        double2 tv = p_two_to[j];
        double f1 = tv.s0;
        double f2 = tv.s1;
        double f = f1 + f2;

        double r1 = fma(dn, -lnof2_by_64_head, v);
        double r2 = dn * lnof2_by_64_tail;
        double r = (r1 + r2) + vt;

        double q = fma(r,
                       fma(r,
                           fma(r,
                               fma(r, 1.38889490863777199667e-03, 8.33336798434219616221e-03),
                               4.16666666662260795726e-02),
                           1.66666666665260878863e-01),
                       5.00000000000000008883e-01);
        q = fma(r*r, q, r);

        expv = fma(f, q, f2) + f1;
	      expv = ldexp(expv, m);

        expv = v > max_exp_arg ? as_double(0x7FF0000000000000L) : expv;
        expv = v < min_exp_arg ? 0.0 : expv;
    }

    // See whether y is an integer.
    // inty = 0 means not an integer.
    // inty = 1 means odd integer.
    // inty = 2 means even integer.

#if defined(COMPILING_POWN) | defined(COMPILING_ROOTN)
    int inty = 2 - (ny & 1);
#else
    int inty;
    {
        int yexp = (int)(ay >> EXPSHIFTBITS_DP64) - EXPBIAS_DP64 + 1;
        inty = yexp < 1 ? 0 : 2;
        inty = yexp > 53 ? 2 : inty;
        long mask = (1L << (53 - yexp)) - 1L;
        int inty1 = (((ay & ~mask) >> (53 - yexp)) & 1L) == 1L ? 1 : 2;
        inty1 = (ay & mask) != 0 ? 0 : inty1;
        inty = !(yexp < 1) & !(yexp > 53) ? inty1 : inty;
    }
#endif

    expv *= inty == 1 & !xpos ? -1.0 : 1.0;

    long ret = as_long(expv);

    // Now all the edge cases

#if defined COMPILING_POWR
    ret = ax < 0x3ff0000000000000L & uy == NINFBITPATT_DP64 ? PINFBITPATT_DP64 : ret;
    ret = ax < 0x3ff0000000000000L & uy == PINFBITPATT_DP64 ? 0L : ret;
    ret = ax == 0x3ff0000000000000L & ay < PINFBITPATT_DP64 ? 0x3ff0000000000000L : ret;
    ret = ax == 0x3ff0000000000000L & ay == PINFBITPATT_DP64 ? QNANBITPATT_DP64 : ret;
    ret = ax > 0x3ff0000000000000L & uy == NINFBITPATT_DP64 ? 0L : ret;
    ret = ax > 0x3ff0000000000000L & uy == PINFBITPATT_DP64 ? PINFBITPATT_DP64 : ret;
    ret = ux < PINFBITPATT_DP64 & ay == 0L ? 0x3ff0000000000000L : ret;
    ret = ax == PINFBITPATT_DP64 & !ypos ? 0L : ret;
    ret = ax == PINFBITPATT_DP64 & ypos ? PINFBITPATT_DP64 : ret;
    ret = ax == PINFBITPATT_DP64 & uy == PINFBITPATT_DP64 ? PINFBITPATT_DP64 : ret;
    ret = ax == PINFBITPATT_DP64 & ay == 0L ? QNANBITPATT_DP64 : ret;
    ret = ax == 0L & !ypos ? PINFBITPATT_DP64 : ret;
    ret = ax == 0L & ypos ? 0L : ret;
    ret = ax == 0L & ay == 0L ? QNANBITPATT_DP64 : ret;
    ret = ax != 0L & !xpos ? QNANBITPATT_DP64 : ret;
    ret = ax > PINFBITPATT_DP64 ? ux : ret;
    ret = ay > PINFBITPATT_DP64 ? uy : ret;
#elif defined COMPILING_POWN
    long xinf = xpos ? PINFBITPATT_DP64 : NINFBITPATT_DP64;
    ret = ax == 0L & !ypos & inty == 1 ? xinf : ret;
    ret = ax == 0L & !ypos & inty == 2 ? PINFBITPATT_DP64 : ret;
    ret = ax == 0L & ypos & inty == 2 ? 0L : ret;
    long xzero = !xpos ? 0x8000000000000000L : 0L;
    ret = ax == 0L & ypos & inty == 1 ? xzero : ret;
    ret = ux == NINFBITPATT_DP64 & !ypos & inty == 1 ? 0x8000000000000000L : ret;
    ret = ux == NINFBITPATT_DP64 & !ypos & inty != 1 ? 0L : ret;
    ret = ux == NINFBITPATT_DP64 & ypos & inty == 1 ? NINFBITPATT_DP64 : ret;
    ret = ux == NINFBITPATT_DP64 & ypos & inty != 1 ? PINFBITPATT_DP64 : ret;
    ret = ux == PINFBITPATT_DP64 & !ypos ? 0L : ret;
    ret = ux == PINFBITPATT_DP64 & ypos ? PINFBITPATT_DP64 : ret;
    ret = ax > PINFBITPATT_DP64 ? ux : ret;
    ret = ny == 0 ? 0x3ff0000000000000L : ret;
#elif defined COMPILING_ROOTN
    ret = !xpos & inty == 2 ? QNANBITPATT_DP64 : ret;
    long xinf = xpos ? PINFBITPATT_DP64 : NINFBITPATT_DP64;
    ret = ax == 0L & !ypos & inty == 1 ? xinf : ret;
    ret = ax == 0L & !ypos & inty == 2 ? PINFBITPATT_DP64 : ret;
    ret = ax == 0L & ypos & inty == 2 ? 0L : ret;
    long xzero = xpos ? 0L : 0x8000000000000000L;
    ret = ax == 0L & ypos & inty == 1 ? xzero : ret;
    ret = ux == NINFBITPATT_DP64 & ypos & inty == 1 ? NINFBITPATT_DP64 : ret;
    ret = ux == NINFBITPATT_DP64 & !ypos & inty == 1 ? 0x8000000000000000L : ret;
    ret = ux == PINFBITPATT_DP64 & !ypos ? 0L : ret;
    ret = ux == PINFBITPATT_DP64 & ypos ? PINFBITPATT_DP64 : ret;
    ret = ax > PINFBITPATT_DP64 ? ux : ret;
    ret = ny == 0 ? QNANBITPATT_DP64 : ret;
#else
    ret = !xpos & inty == 0 ? QNANBITPATT_DP64 : ret;
    ret = ax < 0x3ff0000000000000L & uy == NINFBITPATT_DP64 ? PINFBITPATT_DP64 : ret;
    ret = ax > 0x3ff0000000000000L & uy == NINFBITPATT_DP64 ? 0L : ret;
    ret = ax < 0x3ff0000000000000L & uy == PINFBITPATT_DP64 ? 0L : ret;
    ret = ax > 0x3ff0000000000000L & uy == PINFBITPATT_DP64 ? PINFBITPATT_DP64 : ret;
    long xinf = xpos ? PINFBITPATT_DP64 : NINFBITPATT_DP64;
    ret = ax == 0L & !ypos & inty == 1 ? xinf : ret;
    ret = ax == 0L & !ypos & inty != 1 ? PINFBITPATT_DP64 : ret;
    long xzero = xpos ? 0L : 0x8000000000000000L;
    ret = ax == 0L & ypos & inty == 1 ? xzero : ret;
    ret = ax == 0L & ypos & inty != 1 ? 0L : ret;
    ret = ax == 0L & uy == NINFBITPATT_DP64 ? PINFBITPATT_DP64 : ret;
    ret = ux == 0xbff0000000000000L & ay == PINFBITPATT_DP64 ? 0x3ff0000000000000L : ret;
    ret = ux == NINFBITPATT_DP64 & !ypos & inty == 1 ? 0x8000000000000000L : ret;
    ret = ux == NINFBITPATT_DP64 & !ypos & inty != 1 ? 0L : ret;
    ret = ux == NINFBITPATT_DP64 & ypos & inty == 1 ? NINFBITPATT_DP64 : ret;
    ret = ux == NINFBITPATT_DP64 & ypos & inty != 1 ? PINFBITPATT_DP64 : ret;
    ret = ux == PINFBITPATT_DP64 & !ypos ? 0L : ret;
    ret = ux == PINFBITPATT_DP64 & ypos ? PINFBITPATT_DP64 : ret;
    ret = ax > PINFBITPATT_DP64 ? ux : ret;
    ret = ay > PINFBITPATT_DP64 ? uy : ret;
    ret = ay == 0L ? 0x3ff0000000000000L : ret;
    ret = ux == 0x3ff0000000000000L ? 0x3ff0000000000000L : ret;
#endif

    return as_double(ret);
}

