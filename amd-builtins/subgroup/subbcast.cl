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
#pragma OPENCL EXTENSION cl_khr_subgroups : enable

extern uint __hsail_activelaneshuffle_wavewidth_b32(uint src, uint lid, uint ival, bool useival);
extern ulong __hsail_activelaneshuffle_wavewidth_b64(ulong src, uint lid, ulong ival, bool useival);
extern void __hsail_wavebarrier();

__attribute__((always_inline)) static uint
bcast32(uint a, uint lid)
{
    a = __hsail_activelaneshuffle_wavewidth_b32(a, lid, 0U, false);
    __hsail_wavebarrier();
    return a;
}

extern __attribute__((overloadable, alias("bcast32"))) uint sub_group_broadcast(uint, uint);
extern __attribute__((overloadable, alias("bcast32"))) int sub_group_broadcast(int, uint);
extern __attribute__((overloadable, alias("bcast32"))) float sub_group_broadcast(float, uint);


__attribute__((always_inline)) static ulong
bcast64(ulong a, uint lid)
{
    a = __hsail_activelaneshuffle_wavewidth_b64(a, lid, 0UL, false);
    __hsail_wavebarrier();
    return a;
}

extern __attribute__((overloadable, alias("bcast64"))) ulong sub_group_broadcast(ulong, uint);
extern __attribute__((overloadable, alias("bcast64"))) long sub_group_broadcast(long, uint);
extern __attribute__((overloadable, alias("bcast64"))) double sub_group_broadcast(double, uint);

