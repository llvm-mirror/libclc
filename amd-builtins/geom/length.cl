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
length(float p)
{
    return fabs(p);
}

__attribute__((overloadable, weak,always_inline)) double
length(double p)
{
    return fabs(p);
}

__attribute__((overloadable, weak,always_inline)) float
length(float2 p)
{
    float l2 = dot(p, p);

    if (l2 < FLT_MIN) {
        p *= 0x1.0p+86F;
        return sqrt(dot(p, p)) * 0x1.0p-86F;
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-65F;
        return sqrt(dot(p, p)) * 0x1.0p+65F;
    }

    return sqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) double
length(double2 p)
{
    double l2 = dot(p, p);

    if (l2 < DBL_MIN) {
        p *= 0x1.0p+563;
        return sqrt(dot(p, p)) * 0x1.0p-563;
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-513;
        return sqrt(dot(p, p)) * 0x1.0p+513;
    }

    return sqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) float
length(float3 p)
{
    float l2 = dot(p, p);

    if (l2 < FLT_MIN) {
        p *= 0x1.0p+86F;
        return sqrt(dot(p, p)) * 0x1.0p-86F;
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-66F;
        return sqrt(dot(p, p)) * 0x1.0p+66F;
    }

    return sqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) double
length(double3 p)
{
    double l2 = dot(p, p);

    if (l2 < DBL_MIN) {
        p *= 0x1.0p+563;
        return sqrt(dot(p, p)) * 0x1.0p-563;
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-514;
        return sqrt(dot(p, p)) * 0x1.0p+514;
    }

    return sqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) float
length(float4 p)
{
    float l2 = dot(p, p);

    if (l2 < FLT_MIN) {
        p *= 0x1.0p+86F;
        return sqrt(dot(p, p)) * 0x1.0p-86F;
    }
    else if (l2 == INFINITY) {
        p *= 0x1.0p-66f;
        return sqrt(dot(p, p)) * 0x1.0p+66F;
    }

    return sqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) double
length(double4 p)
{
    double l2 = dot(p, p);

    if (l2 < DBL_MIN) {
        p *= 0x1.0p+563;
        return sqrt(dot(p, p)) * 0x1.0p-563;
    }
    else if (l2 == INFINITY) {
        p *= 0x1.0p-514;
        return sqrt(dot(p, p)) * 0x1.0p+514;
    }

    return sqrt(l2);
}

