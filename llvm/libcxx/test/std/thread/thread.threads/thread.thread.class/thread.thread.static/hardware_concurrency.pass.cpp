//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// UNSUPPORTED: libcpp-has-no-threads
// XFAIL: LIBCXX-AIX-FIXME

// <thread>

// class thread

// unsigned hardware_concurrency();

#include <thread>
#include <cassert>

#include "test_macros.h"

int main(int, char**)
{
    assert(std::thread::hardware_concurrency() > 0);

  return 0;
}
