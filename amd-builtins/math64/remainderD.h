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

static inline double
my_ldexp(double x, int n)
{
    // XXX Have to go twice here because the hardware can't handle the full range (yet)
    int nh = n >> 1;
    return ldexp(ldexp(x, nh), n-nh);
}

#if defined(COMPILING_FMOD)
__attribute__((overloadable, always_inline, weak)) double
fmod(double x, double y)
#elif defined(COMPILING_REMQUO)
__attribute__((overloadable, always_inline, weak)) double
remquo(double x, double y, int *pquo)
#else
__attribute__((overloadable, always_inline, weak)) double
remainder(double x, double y)
#endif
{
    ulong ux = as_ulong(x);
    ulong ax = ux & ~SIGNBIT_DP64;
    ulong xsgn = ux ^ ax;
    double dx = as_double(ax);
    int xexp = convert_int(ax >> EXPSHIFTBITS_DP64);
    int xexp1 = 11 - (int) clz(ax & MANTBITS_DP64);
    xexp1 = xexp < 1 ? xexp1 : xexp;

    ulong uy = as_ulong(y);
    ulong ay = uy & ~SIGNBIT_DP64;
    double dy = as_double(ay);
    int yexp = convert_int(ay >> EXPSHIFTBITS_DP64);
    int yexp1 = 11 - (int) clz(ay & MANTBITS_DP64);
    yexp1 = yexp < 1 ? yexp1 : yexp;

#if !defined COMPILING_FMOD
    int qsgn = ((ux ^ uy) & SIGNBIT_DP64) == 0UL ? 1 : -1;
#endif

    // First assume |x| > |y|

    // Set ntimes to the number of times we need to do a
    // partial remainder. If the exponent of x is an exact multiple
    // of 53 larger than the exponent of y, and the mantissa of x is
    // less than the mantissa of y, ntimes will be one too large
    // but it doesn't matter - it just means that we'll go round
    // the loop below one extra time.
    int ntimes = max(0, (xexp1 - yexp1) / 53);
    double w =  my_ldexp(dy, ntimes * 53);
    w = ntimes == 0 ? dy : w;
    double scale = ntimes == 0 ? 1.0 : 0x1.0p-53;

    // Each time round the loop we compute a partial remainder.
    // This is done by subtracting a large multiple of w
    // from x each time, where w is a scaled up version of y.
    // The subtraction must be performed exactly in quad
    // precision, though the result at each stage can
    // fit exactly in a double precision number.
    int i;
    double t, v, p, pp;

    for (i = 0; i < ntimes; i++) {
        // Compute integral multiplier
        t = trunc(dx / w);

        // Compute w * t in quad precision
        p = w * t;
        pp = fma(w, t, -p);

        // Subtract w * t from dx
        v = dx - p;
        dx = v + (((dx - v) - p) - pp);

        // If t was one too large, dx will be negative. Add back one w.
        dx += dx < 0.0 ? w : 0.0;

        // Scale w down by 2^(-53) for the next iteration
        w *= scale;
    }

    // One more time
    // Variable todd says whether the integer t is odd or not
    t = floor(dx / w);
    long lt = (long)t;
    int todd = lt & 1;

    p = w * t;
    pp = fma(w, t, -p);
    v = dx - p;
    dx = v + (((dx - v) - p) - pp);
    i = dx < 0.0;
    todd ^= i;
    dx += i ? w : 0.0;

#if defined(COMPILING_REMQUO)
    lt -= i;
#endif

    // At this point, dx lies in the range [0,dy)

#if !defined(COMPILING_FMOD)
    // For the fmod function, we're done apart from setting the correct sign.
    //
    // For the remainder function, we need to adjust dx
    // so that it lies in the range (-y/2, y/2] by carefully
    // subtracting w (== dy == y) if necessary. The rigmarole
    // with todd is to get the correct sign of the result
    // when x/y lies exactly half way between two integers,
    // when we need to choose the even integer.

    int al = (2.0*dx > w) | (todd & (2.0*dx == w));
    double dxl = dx - (al ? w : 0.0);

    int ag = (dx > 0.5*w) | (todd & (dx == 0.5*w));
    double dxg = dx - (ag ? w : 0.0);

    dx = dy < 0x1.0p+1022 ? dxl : dxg;
# if defined COMPILING_REMQUO
    lt += dy < 0x1.0p+1022 ? al : ag;
    int quo = ((int)lt & 0x7f) * qsgn;
# endif
#endif

    double ret = as_double(xsgn ^ as_ulong(dx));
    dx = as_double(ax);

    // Now handle |x| == |y|
    int c = dx == dy;
    t = as_double(xsgn);
#if defined COMPILING_REMQUO
    quo = c ? qsgn : quo;
#endif
    ret = c ? t : ret;

    // Next, handle |x| < |y|
    c = dx < dy;
#if defined COMPILING_REMQUO
    quo = c ? 0 : quo;
#endif
    ret = c ? x : ret;

#if !defined COMPILING_FMOD
    c &= (yexp < 1023 & 2.0*dx > dy) | (dx > 0.5*dy);
# if defined COMPILING_REMQUO
    quo = c ? qsgn : quo;
# endif
    // we could use a conversion here instead since qsgn = +-1
    p = qsgn == 1 ? -1.0 : 1.0;
    t = fma(y, p, x);
    ret = c ? t : ret;
#endif

    // We don't need anything special for |x| == 0

    // |y| is 0
    c = dy == 0.0;
#if defined COMPILING_REMQUO
    quo = c ? 0 : quo;
#endif
    ret = c ? as_double(QNANBITPATT_DP64) : ret;

    // y is +-Inf, NaN
    c = yexp > BIASEDEMAX_DP64;
#if defined COMPILING_REMQUO
    quo = c ? 0 : quo;
#endif
    t = y == y ? x : y;
    ret = c ? t : ret;

    // x is +=Inf, NaN
    c = xexp > BIASEDEMAX_DP64;
#if defined COMPILING_REMQUO
    quo = c ? 0 : quo;
#endif
    ret = c ? as_double(QNANBITPATT_DP64) : ret;

#if defined COMPILING_REMQUO
    *pquo = quo;
#endif
    return ret;
}

