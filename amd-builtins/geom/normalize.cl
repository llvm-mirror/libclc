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
normalize(float p)
{
    return sign(p);
}

__attribute__((overloadable, weak,always_inline)) double
normalize(double p)
{
    return sign(p);
}

__attribute__((overloadable, weak,always_inline)) float2
normalize(float2 p)
{
    if (all(p == (float2)0.0F))
	return p;

    float l2 = dot(p, p);

    if (l2 < FLT_MIN) {
        p *= 0x1.0p+86F;
        l2 = dot(p, p);
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-65f;
        l2 = dot(p, p);
        if (l2 == INFINITY) {
            p = copysign(select((float2)0.0F, (float2)1.0F, isinf(p)), p);
            l2 = dot(p, p);
        }
    }
    return p * rsqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) double2
normalize(double2 p)
{
    if (all(p == (double2)0.0))
	return p;

    double l2 = dot(p, p);

    if (l2 < DBL_MIN) {
        p *= 0x1.0p+563;
        l2 = dot(p, p);
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-513;
        l2 = dot(p, p);
        if (l2 == INFINITY) {
            p = copysign(select((double2)0.0, (double2)1.0, isinf(p)), p);
            l2 = dot(p, p);
        }
    }
    return p * rsqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) float3
normalize(float3 p)
{
    if (all(p == (float3)0.0F))
	return p;

    float l2 = dot(p, p);

    if (l2 < FLT_MIN) {
        p *= 0x1.0p+86F;
        l2 = dot(p, p);
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-66f;
        l2 = dot(p, p);
        if (l2 == INFINITY) {
            p = copysign(select((float3)0.0F, (float3)1.0F, isinf(p)), p);
            l2 = dot(p, p);
        }
    }
    return p * rsqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) double3
normalize(double3 p)
{
    if (all(p == (double3)0.0))
	return p;

    double l2 = dot(p, p);

    if (l2 < DBL_MIN) {
        p *= 0x1.0p+563;
        l2 = dot(p, p);
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-514;
        l2 = dot(p, p);
        if (l2 == INFINITY) {
            p = copysign(select((double3)0.0, (double3)1.0, isinf(p)), p);
            l2 = dot(p, p);
        }
    }
    return p * rsqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) float4
normalize(float4 p)
{
    if (all(p == (float4)0.0F))
	return p;

    float l2 = dot(p, p);

    if (l2 < FLT_MIN) {
        p *= 0x1.0p+86F;
        l2 = dot(p, p);
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-66f;
        l2 = dot(p, p);
        if (l2 == INFINITY) {
            p = copysign(select((float4)0.0F, (float4)1.0F, isinf(p)), p);
            l2 = dot(p, p);
        }
    }
    return p * rsqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) double4
normalize(double4 p)
{
    if (all(p == (double4)0.0))
	return p;

    double l2 = dot(p, p);

    if (l2 < DBL_MIN) {
        p *= 0x1.0p+563;
        l2 = dot(p, p);
    } else if (l2 == INFINITY) {
        p *= 0x1.0p-514;
        l2 = dot(p, p);
        if (l2 == INFINITY) {
            p = copysign(select((double4)0.0, (double4)1.0, isinf(p)), p);
            l2 = dot(p, p);
        }
    }
    return p * rsqrt(l2);
}

