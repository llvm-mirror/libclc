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

// tan(x + xx) approximation valid on the interval [-pi/4,pi/4].
// Also return -1/tan(x + xx) in .y
static inline double2
tan_piby4(double x, double xx)
{
    const double piby4_lead = 7.85398163397448278999e-01; // 0x3fe921fb54442d18
    const double piby4_tail = 3.06161699786838240164e-17; // 0x3c81a62633145c06

    // In order to maintain relative precision transform using the identity:
    // tan(pi/4-x) = (1-tan(x))/(1+tan(x)) for arguments close to pi/4.
    // Similarly use tan(x-pi/4) = (tan(x)-1)/(tan(x)+1) close to -pi/4.

    int ca = x >  0.68;
    int cb = x < -0.68;
    double transform = ca ?  1.0 : 0.0;
    transform = cb ? -1.0 : transform;

    double tx = fma(-transform, x, piby4_lead) + fma(-transform, xx, piby4_tail);
    int c = ca | cb;
    x = c ? tx : x;
    xx = c ? 0.0 : xx;

    // Core Remez [2,3] approximation to tan(x+xx) on the interval [0,0.68].
    double t1 = x;
    double r = fma(2.0, x*xx, x*x);

    double a = fma(r,
                   fma(r, 0.224044448537022097264602535574e-3, -0.229345080057565662883358588111e-1),
                   0.372379159759792203640806338901e0);

    double b = fma(r,
                   fma(r,
                       fma(r, -0.232371494088563558304549252913e-3, 0.260656620398645407524064091208e-1),
                       -0.515658515729031149329237816945e0),
                   0.111713747927937668539901657944e1);

    double t2 = fma(MATH_DIVIDE(a, b), x*r, xx);

    double tp = t1 + t2;

    // Compute -1.0/(t1 + t2) accurately
    double z1 = as_double(as_long(tp) & 0xffffffff00000000L);
    double z2 = t2 - (z1 - t1);
    double trec = -MATH_RECIP(tp);
    double trec_top = as_double(as_long(trec) & 0xffffffff00000000L);

    double tpr = fma(fma(trec_top, z2, fma(trec_top, z1, 1.0)), trec, trec_top);

    double tpt = transform * (1.0 - MATH_DIVIDE(2.0*tp, 1.0 + tp));
    double tptr = transform * (MATH_DIVIDE(2.0*tp, tp - 1.0) - 1.0);

    double2 ret;
    ret.lo = c ? tpt : tp;
    ret.hi = c ? tptr : tpr;
    return ret;
}

