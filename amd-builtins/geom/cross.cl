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

__attribute__((overloadable, weak,always_inline)) float3
cross(float3 p0, float3 p1)
{
    return (float3)(p0.y * p1.z - p0.z * p1.y,
                    p0.z * p1.x - p0.x * p1.z,
                    p0.x * p1.y - p0.y * p1.x);
}

__attribute__((overloadable, weak,always_inline)) double3
cross(double3 p0, double3 p1)
{
    return (double3)(p0.y * p1.z - p0.z * p1.y,
                     p0.z * p1.x - p0.x * p1.z,
                     p0.x * p1.y - p0.y * p1.x);
}

__attribute__((overloadable, weak,always_inline)) float4
cross(float4 p0, float4 p1)
{
    return (float4)(p0.y * p1.z - p0.z * p1.y,
                    p0.z * p1.x - p0.x * p1.z,
                    p0.x * p1.y - p0.y * p1.x,
                    p0.w * p1.w - p0.w * p1.w);
}

__attribute__((overloadable, weak,always_inline)) double4
cross(double4 p0, double4 p1)
{
    return (double4)(p0.y * p1.z - p0.z * p1.y,
                     p0.z * p1.x - p0.x * p1.z,
                     p0.x * p1.y - p0.y * p1.x,
                     p0.w * p1.w - p0.w * p1.w);
}

