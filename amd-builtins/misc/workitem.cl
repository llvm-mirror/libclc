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

extern __attribute__((const)) uint __hsail_get_global_size(uint);
extern __attribute__((const)) uint __hsail_get_global_id(uint);
extern __attribute__((const)) uint __hsail_workgroup_size(uint);
extern __attribute__((const)) uint __hsail_currentworkgroup_size(uint);
extern __attribute__((const)) uint __hsail_get_local_id(uint);
extern __attribute__((const)) uint __hsail_get_num_groups(uint);
extern __attribute__((const)) uint __hsail_get_group_id(uint);
extern __attribute__((const)) uint   __hsail_get_work_dim(void);
extern __attribute__((const)) uint  __hsail_ld_kernarg_u32(uint);
extern __attribute__((const)) ulong __hsail_ld_kernarg_u64(uint);
extern __attribute__((pure)) uint __hsail_workitemid_flat(void);

// FIXME - this will change to ulong soon
extern __attribute__((pure)) uint __hsail_workitemid_flatabs(void);

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_global_offset(uint d) {
  if (sizeof(size_t) == 4) { // 32 bit
    switch(d) {
      default:
        return 0;
      case 0:
        return __hsail_ld_kernarg_u32(0);
      case 1:
        return __hsail_ld_kernarg_u32(4);
      case 2:
        return __hsail_ld_kernarg_u32(8);
     }
  } else { // 64 bit
    switch(d) {
      default:
        return 0;
      case 0:
        return __hsail_ld_kernarg_u64(0);
      case 1:
        return __hsail_ld_kernarg_u64(8);
      case 2:
        return __hsail_ld_kernarg_u64(16);
    }
  }
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_global_id(uint d) {
  size_t id;
  size_t o = get_global_offset(d);
  switch(d) {
    default:
      id = 0;
      break;
    case 0:
      id = __hsail_get_global_id(0);
      break;
    case 1:
      id = __hsail_get_global_id(1);
      break;
    case 2:
      id = __hsail_get_global_id(2);
      break;
  }

  return o + id;
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_local_id(uint d) {
  switch(d) {
    default:
      return 0;
    case 0:
      return __hsail_get_local_id(0);
    case 1:
      return __hsail_get_local_id(1);
    case 2:
      return __hsail_get_local_id(2);
  }
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_group_id(uint d) {
  switch(d) {
    default:
      return 0;
    case 0:
      return __hsail_get_group_id(0);
    case 1:
      return __hsail_get_group_id(1);
    case 2:
      return __hsail_get_group_id(2);
  }
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_global_size(uint d) {
  switch(d) {
    default:
      return 1;
    case 0:
      return __hsail_get_global_size(0);
    case 1:
      return __hsail_get_global_size(1);
    case 2:
      return __hsail_get_global_size(2);
  }
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_local_size(uint d) {
  switch(d) {
    default:
      return 1;
    case 0:
      return __hsail_currentworkgroup_size(0);
    case 1:
      return __hsail_currentworkgroup_size(1);
    case 2:
      return __hsail_currentworkgroup_size(2);
  }
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_num_groups(uint d) {
  switch(d) {
    default:
      return 1;
    case 0:
      return __hsail_get_num_groups(0);
    case 1:
      return __hsail_get_num_groups(1);
    case 2:
      return __hsail_get_num_groups(2);
  }
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
uint get_work_dim() {
  return __hsail_get_work_dim();
}

#if __OPENCL_C_VERSION__ >= 200
#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_enqueued_local_size(uint d) {
  switch(d) {
    default:
      return 1;
    case 0:
      return __hsail_workgroup_size(0);
    case 1:
      return __hsail_workgroup_size(1);
    case 2:
      return __hsail_workgroup_size(2);
  }
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_global_linear_id(void) {
#if defined NO_WORKITEM_FLATABS
    return (__hsail_get_global_id(2) * __hsail_get_global_size(1) +
            __hsail_get_global_id(1)) * __hsail_get_global_size(0) +
	    __hsail_get_global_id(0);
#else
    return __hsail_workitemid_flatabs();
#endif
}

#ifdef __clang__
    __attribute__((always_inline, overloadable))
#else
__attribute__((always_inline))
#endif
size_t get_local_linear_id(void) {
    return __hsail_workitemid_flat();
}

#endif

