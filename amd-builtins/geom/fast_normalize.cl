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
fast_normalize(float p)
{
    return normalize(p);
}

__attribute__((overloadable, weak,always_inline)) float2
fast_normalize(float2 p)
{
    float l2 = dot(p, p);
    return l2 == 0.0F ? p : p * half_rsqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) float3
fast_normalize(float3 p)
{
    float l2 = dot(p, p);
    return l2 == 0.0F ? p : p * half_rsqrt(l2);
}

__attribute__((overloadable, weak,always_inline)) float4
fast_normalize(float4 p)
{
    float l2 = dot(p, p);
    return l2 == 0.0F ? p : p * half_rsqrt(l2);
}

