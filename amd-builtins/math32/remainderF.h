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

#if !defined(SUBNORMALS_SUPPORTED)
static inline float
scaleFullRangef32(float y, float t)
{
    float ay, ty, r = 0;
    int k, iiy, iy, exp_iy0, exp_iy, manty, signy, miy;
    int delta, shift, ir;

    ay = fabs(t);
    k = ay > 1024 ? 1024 : (int) ay;
    k = t < 0 ? -k : k;
    t = (float) k;

    iiy = as_int(y);
    iy = iiy & EXSIGNBIT_SP32;
    signy = iiy & SIGNBIT_SP32;
    ay = as_float(iy);

    exp_iy0 = iy & EXPBITS_SP32;
    manty = iy & MANTBITS_SP32;

    //sub-normal
    ty = exp_iy0 == 0 ? (float) manty : as_float(iy);
    k = exp_iy0 == 0 ? k - 149 : k;
    ay = ty;
    iy = as_int(ay);
    exp_iy0 = iy & EXPBITS_SP32;
    exp_iy = (exp_iy0 >> EXPSHIFTBITS_SP32) - EXPBIAS_SP32;
    // add k to y's exponent
    r = as_float(iy + (k << EXPSHIFTBITS_SP32));
    r = (exp_iy + k) > 127 ? as_float(PINFBITPATT_SP32) : r;
    // add k to y's exponent
    delta = -126 - (exp_iy + k);

    // sub-normal
    miy = iy & MANTBITS_SP32;
    miy |= IMPBIT_SP32;
    shift = delta > 23 ? 24 : delta;
    shift = delta < 0 ? 0 : shift;
    miy >>= shift;
    r = delta > 0 ? as_float(miy) : r;
    r = t > (float) (2 * EMAX_SP32) ? as_float(PINFBITPATT_SP32) : r;
    ir = as_int(r);
    r = ir <= PINFBITPATT_SP32 ? as_float(as_int(r) | signy) : r;
    return r;
}

/* Scales the float x by 2.0**n.
Assumes 2*EMIN <= n <= 2*EMAX, though this condition is not checked. */
static inline float
scaleFloat_2(float x, int n)
{
    float t1, t2;
    int n1, n2;
    n1 = n / 2;
    n2 = n - n1;
    /* Construct the numbers t1 = 2.0**n1 and t2 = 2.0**n2 */
    t1 = as_float((n1 + EXPBIAS_SP32) << EXPSHIFTBITS_SP32);
    t2 = as_float((n2 + EXPBIAS_SP32) << EXPSHIFTBITS_SP32);
    return (x * t1) * t2;
}

/* Scales the float x by 2.0**n.
   Assumes EMIN <= n <= EMAX, though this condition is not checked. */
static inline float
scaleFloat_1(float x, int n)
{
    float t;
    /* Construct the number t = 2.0**n */
    t = as_float((n + EXPBIAS_SP32) << EXPSHIFTBITS_SP32);
    return x * t;
}

/* Computes the exact product of x and y, the result being the
nearly double length number (z,zz) */
static inline void
mul12f(float x, float y, float *z, float *zz)
{
    float hx, tx, hy, ty;
    // Split x into hx (head) and tx (tail). Do the same for y.
    uint u;
    u = as_uint(x);
    u &= 0xfffff000;
    hx = as_float(u);
    tx = x - hx;
    u = as_uint(y);
    u &= 0xfffff000;
    hy = as_float(u);
    ty = y - hy;
    *z = x * y;
    *zz = (((hx * hy - *z) + hx * ty) + tx * hy) + tx * ty;
}

#endif //SUBNORMALS_SUPPORTED

#if defined(COMPILING_FMOD)
__attribute__((overloadable)) float
fmod(float x, float y)
#elif defined(COMPILING_REMQUO)
__attribute__((overloadable)) float
remquo(float x, float y, int *quo)
#else
__attribute__((overloadable)) float
remainder(float x, float y)
#endif
{
#if !defined(SUBNORMALS_SUPPORTED)

    const int loop_scale = 12;
    const float fscale = 1.0f / (float) (1 << loop_scale);

    int ntimes;
    float ret = 0;
    int ui_x, ui_y, ui_ax, ui_ay, xexp, yexp, signx;
    float af_x, af_y, af_ybase, fx, fxp, fxm, fy, w, scale, t, c, cc, v;
    float yscale, scaled_w, saved_w, div, sdiv, ratio, sratio, fxexp, sub_fx;
    int iw_scaled, wexp, it, i, ifx, ex, ey;;
    float xr, xr0, xr_base, yr;
    uint q;

    ui_x = as_int(x);
    ui_y = as_int(y);
    ui_ax = ui_x & EXSIGNBIT_SP32;
    ui_ay = ui_y & EXSIGNBIT_SP32;

    /* special case handle */
#if defined(COMPILING_REMQUO)
    *quo = 0;
#endif
    if (ui_ax > PINFBITPATT_SP32)
	return x;
    if (ui_ax == PINFBITPATT_SP32)
	return as_float(QNANBITPATT_SP32);
    if (ui_ay > PINFBITPATT_SP32)
	return y;
    if (ui_ay == PINFBITPATT_SP32)
	return x;
    if (ui_ay == 0 && ui_ax == 0)
	return as_float(QNANBITPATT_SP32);
    if (ui_ax == 0)
	return x;
    if (ui_ay == 0)
	return as_float(QNANBITPATT_SP32);

    signx = ui_x & SIGNBIT_SP32;
#if defined(COMPILING_REMQUO)
    int signy = ui_y & SIGNBIT_SP32;
#endif
    af_x = as_float(ui_ax);
    af_ybase = af_y = as_float(ui_ay);
    yexp = (int) ((ui_y & EXPBITS_SP32) >> EXPSHIFTBITS_SP32);

    yscale = (float) ((yexp < 48 && ui_ay != 0) ? (48 - yexp) : 0);
    if (yscale != 0) {
	af_y = scaleFullRangef32(af_ybase, yscale);
    }

    ui_y = as_int(af_y);
    yexp = (int) ((ui_y & EXPBITS_SP32) >> EXPSHIFTBITS_SP32);
    xexp = (int) ((ui_x & EXPBITS_SP32) >> EXPSHIFTBITS_SP32);
    fx = af_x;
    fy = af_y;

    /* Set ntimes to the number of times we need to do a
       partial remainder. If the exponent of x is an exact multiple
       of 24 larger than the exponent of y, and the mantissa of x is
       less than the mantissa of y, ntimes will be one too large
       but it doesn't matter - it just means that we'll go round
       the loop below one extra time. */
    ntimes = (xexp - yexp) / loop_scale;
    ntimes = xexp <= yexp ? 0 : ntimes;

    /* Set w = y * 2^(ntimes*loop_scale) */
    w = scaleFloat_2(fy, ntimes*loop_scale);
    w = ntimes == 0 ? fy : w;

    /* Set scale = 2^(-loop_scale) */
    scale = ntimes == 0 ? 1.0f : fscale;

    // make sure recip does not overflow
    wexp = (int) ((as_int(w) & EXPBITS_SP32) >> EXPSHIFTBITS_SP32) - EXPBIAS_SP32;
    saved_w = w;
    scaled_w = scaleFloat_1(w, -14);
    iw_scaled = wexp > 105 & wexp <= 127;
    w = iw_scaled & ntimes > 0 ? scaled_w : w;

    /* Each time round the loop we compute a partial remainder.
       This is done by subtracting a large multiple of w
       from x each time, where w is a scaled up version of y.
       The subtraction can be performed exactly when performed
       in double precision, and the result at each stage can
       fit exactly in a single precision number. */
    for (i = 0; i < ntimes; i++) {
	/* Set fx = fx - w * t, where t is equal to trunc(dx/w). */
	div = __amdil_improved_div_f32(fx, w);
	sdiv = scaleFloat_1(div, -14);
	div = iw_scaled ? sdiv : div;
	t = floor(div);
	w = saved_w;
	iw_scaled = 0;

	/* At this point, t may be one too large due to rounding of fx/w */

	/* Compute w * t in quad precision */
	mul12f(w, t, &c, &cc);

	/* Subtract w * t from fx */
	v = fx - c;
	fx = v + (((fx - v) - c) - cc);

	/* If t was one too large, fx will be negative. Add back one w */
	/* It might be possible to speed up this loop by finding
	   a way to compute correctly truncated t directly from fx and w.
	   We would then avoid the need for this check on negative fx. */
	fxp = fx + w;
	fxm = fx - w;
	fx = fx < 0.0f ? fxp : fx;
	fx = fx >= w ? fxm : fx;

	/* Scale w down by for the next iteration */
	w *= scale;
	saved_w = w;
    }

    /* One more time */
    // iw = as_int(w);
    ifx = as_int(fx);
    fxexp = (int) ((ifx & EXPBITS_SP32) >> EXPSHIFTBITS_SP32);
    // wexp = (int) ((iw & EXPBITS_SP32) >> EXPSHIFTBITS_SP32);
    sub_fx = fx;
    // make sure recip does not overflow
    wexp = (int) ((as_int(w) & EXPBITS_SP32) >> EXPSHIFTBITS_SP32) - EXPBIAS_SP32;
    saved_w = w;
    scaled_w = scaleFloat_1(w, -14);
    iw_scaled = wexp > 105 & wexp <= 127;
    w = iw_scaled ? scaled_w : w;
    ratio = __amdil_improved_div_f32(fx, w);
    sratio = scaleFloat_1(ratio, -14);
    ratio = iw_scaled ? sratio : ratio;
    t = floor(ratio);
    it = (int) t;

    w = saved_w;
    mul12f(w, t, &c, &cc);

    v = fx - c;
    fx = v + (((fx - v) - c) - cc);

    if (fx < 0.0f) {
	fx += w;
	it--;
    }

    if (fx >= w) {
	fx -= w;
	it++;
    }

    // sub-normal fax
    fx = fxexp == 0 ? sub_fx : fx;

#if !defined(COMPILING_FMOD)
    float scaleback = 0;
#endif

    // in case fx == 0 and we'got a divisor
    it = (yscale > 30) ? 0 : ((unsigned int) it << (int) yscale);

    if (as_int(fx) != 0 && yscale != 0) {
	xr = fx;
	xr_base = fx;
	yr = af_ybase;
	q = 0;
	ex = ilogb(fx);
	ey = ilogb(af_ybase);

	yr = (float) scaleFullRangef32(af_ybase, (float) -ey);
	xr = (float) scaleFullRangef32(fx, (float) -ex);

	for (i = ex - ey; i > 0; i--) {
	    q <<= 1;
	    xr0 = xr;
	    xr = (xr0 >= yr) ? xr0 - yr : xr0;
	    q = (xr0 >= yr) ? q + 1 : q;
	    xr += xr;
	}
	q <<= 1;
	xr0 = xr;
	xr = (xr0 >= yr) ? xr0 - yr : xr0;
	q = (xr0 >= yr) ? q + 1 : q;
	xr = scaleFullRangef32(xr, (float) ey);

	fx = (ex - ey >= 0) ? xr : xr_base;
#if !defined(COMPILING_FMOD)
	q = (ex - ey >= 0) ? q : 0;
	it += q;

	xexp = (int) ((as_int(fx) & EXPBITS_SP32) >> EXPSHIFTBITS_SP32);

	w = af_ybase;
	if (xexp < 24) {
	    fx = scaleFullRangef32(fx, 48);
	    w = scaleFullRangef32(af_ybase, 48);
	    scaleback = -48;
	}
#endif
    }
#if !defined(COMPILING_FMOD)
    /* At this point, dx lies in the range [0,dy) */
    /* For the remainder function, we need to adjust dx
       so that it lies in the range (-y/2, y/2] by carefully
       subtracting w (== fy == y) if necessary. */
    if (fx * 2.f > w || ((fx * 2.f == w) && (it & 1))) {
	fx -= w;
	it++;
    }
    if (scaleback != 0) {
	fx = scaleFullRangef32(fx, scaleback);
    }
#endif

    ret = (signx) ? as_float(as_int(fx) ^ SIGNBIT_SP32) : fx;
#if defined(COMPILING_REMQUO)
    it = (signx ^ signy) ? -it : it;
    *quo = it;
#endif

    return ret;


#else

    x = FTZ(x);
    y = FTZ(y);

    int ux = as_int(x);
    int ax = ux & EXSIGNBIT_SP32;
    float xa = as_float(ax);
    int sx = ux ^ ax;
    int ex = ax >> EXPSHIFTBITS_SP32;

    int uy = as_int(y);
    int ay = uy & EXSIGNBIT_SP32;
    float ya = as_float(ay);
#if defined COMPILING_REMQUO
    int sy = uy ^ ay;
#endif
    int ey = ay >> EXPSHIFTBITS_SP32;

    float xr = as_float(0x3f800000 | (ax & 0x007fffff));
    float yr = as_float(0x3f800000 | (ay & 0x007fffff));
    int c;
    int k = ex - ey;

#if defined COMPILING_FMOD
# define BIT c = xr >= yr; xr -= c ? yr : 0.0f; xr += xr
#else
    uint q = 0;
# define BIT c = xr >= yr; q = (q << 1) | c; xr -= c ? yr : 0.0f; xr += xr
#endif

    while (k > 3) {
	BIT;
	BIT;
	BIT;
	BIT;
	k -= 4;
    }

    while (k > 0) {
	BIT;
	--k;
    }

#if !defined COMPILING_FMOD
    c = xr > yr;
    q = (q << 1) | c;
#else
    c = xr >= yr;
#endif
    xr -= c ? yr : 0.0f;

    int lt = ex < ey;

#if !defined COMPILING_FMOD
    q = lt ? 0 : q;
#endif
    xr = lt ? xa : xr;
    yr = lt ? ya : yr;

#if !defined COMPILING_FMOD
    c = (yr < 2.0f * xr) | ((yr == 2.0f * xr) & (q & 0x1) == 0x1);
    xr -= c ? yr : 0.0f;
    q += c;
#endif

    float s = as_float(ey << EXPSHIFTBITS_SP32);
    xr *= lt ? 1.0f : s;

#if defined COMPILING_REMQUO
    int qsgn = sx == sy ? 1 : -1;
    int quot = (q & 0x7f) * qsgn;
#endif

    c = ax == ay;
#if defined COMPILING_REMQUO
    quot = c ? qsgn : quot;
#endif
    xr = c ? 0.0f : xr;

    xr = as_float(sx ^ as_int(xr));

    c = ax > PINFBITPATT_SP32 | ay > PINFBITPATT_SP32 | ax == PINFBITPATT_SP32 | ay == 0;
#if defined COMPILING_REMQUO
    quot = c ? 0 : quot;
#endif
    xr = c ? as_float(QNANBITPATT_SP32) : xr;

#if defined COMPILING_REMQUO
    *quo = quot;
#endif

    return xr;

#endif
}

