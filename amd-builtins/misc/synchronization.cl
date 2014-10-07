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

extern void __hsail_memfence();
extern void __hsail_memfence_global();
extern void __hsail_memfence_group();
extern void __hsail_barrier();

void mem_fence_impl(uint val) {
  if (val == CLK_GLOBAL_MEM_FENCE) {
    __hsail_memfence_global();
  } else if (val == CLK_LOCAL_MEM_FENCE) {
    __hsail_memfence_group();
  } else {
    __hsail_memfence();
  }
}
#ifdef __clang__
__attribute__((overloadable))
#endif
void mem_fence(uint val) {
  mem_fence_impl(val);
}

#ifdef __clang__
__attribute__((overloadable))
#endif
void read_mem_fence(uint val) {
  mem_fence_impl(val);
}

#ifdef __clang__
__attribute__((overloadable))
#endif
void write_mem_fence(uint val) {
  mem_fence_impl(val);
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline))
void barrier(uint flags) {
  __hsail_barrier();
}
