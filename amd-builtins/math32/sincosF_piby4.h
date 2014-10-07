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

static inline float sinf_piby4_new(float x, float y)
{
    // Taylor series for sin(x) is x - x^3/3! + x^5/5! - x^7/7! ...
    // = x * (1 - x^2/3! + x^4/5! - x^6/7! ...
    // = x * f(w)
    // where w = x*x and f(w) = (1 - w/3! + w^2/5! - w^3/7! ...
    // We use a minimax approximation of (f(w) - 1) / w
    // because this produces an expansion in even powers of x.

    const float c1 = -0.1666666666e0f;
    const float c2 = 0.8333331876e-2f;
    const float c3 = -0.198400874e-3f;
    const float c4 = 0.272500015e-5f;
    const float c5 = -2.5050759689e-08f; // 0xb2d72f34
    const float c6 = 1.5896910177e-10f;	 // 0x2f2ec9d3

    float z = x * x;
    float v = z * x;
    float r = mad(z, mad(z, mad(z, mad(z, c6, c5), c4), c3), c2);
    float ret = x - mad(v, -c1, mad(z, mad(y, 0.5f, -v*r), -y));

    return ret;
}

static inline float cosf_piby4_new(float x, float y)
{
    // Taylor series for cos(x) is 1 - x^2/2! + x^4/4! - x^6/6! ...
    // = f(w)
    // where w = x*x and f(w) = (1 - w/2! + w^2/4! - w^3/6! ...
    // We use a minimax approximation of (f(w) - 1 + w/2) / (w*w)
    // because this produces an expansion in even powers of x.

    const float c1 = 0.416666666e-1f;
    const float c2 = -0.138888876e-2f;
    const float c3 = 0.248006008e-4f;
    const float c4 = -0.2730101334e-6f;
    const float c5 = 2.0875723372e-09f;	 // 0x310f74f6
    const float c6 = -1.1359647598e-11f; // 0xad47d74e

    float z = x * x;
    float r = z * mad(z, mad(z, mad(z, mad(z, mad(z, c6,  c5), c4), c3), c2), c1);

    // if |x| < 0.3
    float qx = 0.0f;

    int ix = as_int(x) & EXSIGNBIT_SP32;

    //  0.78125 > |x| >= 0.3
    float xby4 = as_float(ix - 0x01000000);
    qx = (ix >= 0x3e99999a) & (ix <= 0x3f480000) ? xby4 : qx;

    // x > 0.78125
    qx = ix > 0x3f480000 ? 0.28125f : qx;

    float hz = mad(z, 0.5f, -qx);
    float a = 1.0f - qx;
    float ret = a - (hz - mad(z, r, -x*y));
    return ret;
}

