// RUN: %clangxx %fsycl-host-only -fsyntax-only -Xclang -verify -Xclang -verify-ignore-unexpected=note %s
#include <sycl/sycl.hpp>

// expected-warning@sycl/backend/cuda.hpp:17 {{sycl/backend/cuda.hpp is deprecated and not required anymore}}
#include <sycl/backend/cuda.hpp>

// expected-warning@sycl/backend/level_zero.hpp:16 {{sycl/backend/level_zero.hpp usage is deprecated, include sycl/ext/oneapi/backend/level_zero.hpp instead}}
#include <sycl/backend/level_zero.hpp>