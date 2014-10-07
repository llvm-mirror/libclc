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

__attribute__((overloadable, weak,always_inline)) float
degrees(float radians)
{
    // 180/pi = ~57.29577951308232087685 or 0x1.ca5dc1a63c1f8p+5 or 0x1.ca5dc2p+5F
    return 0x1.ca5dc2p+5F * radians;
}

__attribute__((overloadable, weak,always_inline)) double
degrees(double radians)
{
    // 180/pi = ~57.29577951308232087685 or 0x1.ca5dc1a63c1f8p+5 or 0x1.ca5dc2p+5F
    return 0x1.ca5dc1a63c1f8p+5 * radians;
}

//! Converts degrees to radians, i.e. (PI / 180) * degrees.
//
__attribute__((overloadable, weak,always_inline)) float
radians(float degrees)
{
    // pi/180 = ~0.01745329251994329577 or 0x1.1df46a2529d39p-6 or 0x1.1df46ap-6F
    return 0x1.1df46ap-6F * degrees;
}

__attribute__((overloadable, weak,always_inline)) double
radians(double degrees)
{
    // pi/180 = ~0.01745329251994329577 or 0x1.1df46a2529d39p-6 or 0x1.1df46ap-6F
    return 0x1.1df46a2529d39p-6 * degrees;
}

