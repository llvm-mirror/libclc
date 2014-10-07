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
#if __OPENCL_C_VERSION__ >= 200

#ifndef NULL
#define NULL 0
#endif

extern __attribute__((const)) uint  __hsail_ld_kernarg_u32(uint);
extern __attribute__((const)) ulong __hsail_ld_kernarg_u64(uint);

#define OFFSET 8

__global char* __printf_alloc(unsigned int bytes)
{
  // Functionality:
  // The __get_printf_ptr is a builtin that is replaced by
  // the backend.  The first 8 bytes of the buffer returned
  // by the call are skipped.
  // buffer[0] maintains the latest offset in the buffer. The value
  //  is updated using atomic adds for the number of bytes
  //  requested in the function argument.
  // buffer[4] has the size of the buffer
  //  when access needs to go over buffer[0] + size of buffer
  //  i.e. we have the buffer overflow condition -- we return NULL
  // The buffer size is hard limited by sizeof(uint)
  //
  __global char* ptr;
  if (sizeof(size_t) == 4)
    ptr = (__global char*) __hsail_ld_kernarg_u32(12);
  else
    ptr = (__global char*) __hsail_ld_kernarg_u64(24);
  uint size = ((global uint *)ptr)[1];
  uint offset = atomic_load_explicit((__global atomic_uint *)ptr,
                                     memory_order_acquire, memory_scope_device);
  for (;;) {
    if (OFFSET + offset + bytes > size)
      return NULL;
    if (atomic_compare_exchange_strong_explicit((__global atomic_uint *)ptr,
        &offset, offset+bytes, memory_order_acq_rel, memory_order_acquire,
        memory_scope_device))
      break;
  }
  return ptr + OFFSET + offset;
}
#endif
