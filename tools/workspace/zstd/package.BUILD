# -*- python -*-

# Copyright 2018 Josh Pieper, jjp@pobox.com.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@com_github_mjbots_bazel_deps//tools/workspace:template_file.bzl",
     "template_file")

package(default_visibility = ["//visibility:public"])

# Ported from build/meson/lib/meson.build
cc_library(
    name = "zstd",
    hdrs = [
        'lib/zstd.h',
        'lib/deprecated/zbuff.h',
        'lib/dictBuilder/zdict.h',
        'lib/common/zstd_errors.h',
    ],
    srcs = ['lib/' + x for x in [
        'common/bitstream.h',
        'common/compiler.h',
        'common/cpu.h',
        'common/debug.h',
        'common/entropy_common.c',
        'common/error_private.c',
        'common/error_private.h',
        'common/fse.h',
        'common/fse_decompress.c',
        'common/huf.h',
        'common/mem.h',
        'common/pool.c',
        'common/pool.h',
        'common/threading.c',
        'common/threading.h',
        'common/xxhash.c',
        'common/xxhash.h',
        'common/zstd_common.c',
        'common/zstd_errors.h',
        'common/zstd_internal.h',
        'compress/fse_compress.c',
        'compress/hist.c',
        'compress/hist.h',
        'compress/huf_compress.c',
        'compress/zstd_compress.c',
        'compress/zstd_compress_internal.h',
        'compress/zstd_compress_literals.c',
        'compress/zstd_compress_literals.h',
        'compress/zstd_compress_sequences.c',
        'compress/zstd_compress_sequences.h',
        'compress/zstd_cwksp.h',
        'compress/zstd_double_fast.c',
        'compress/zstd_double_fast.h',
        'compress/zstd_fast.c',
        'compress/zstd_fast.h',
        'compress/zstd_lazy.c',
        'compress/zstd_lazy.h',
        'compress/zstd_ldm.c',
        'compress/zstd_ldm.h',
        'compress/zstd_opt.c',
        'compress/zstd_opt.h',
        'compress/zstdmt_compress.c',
        'compress/zstdmt_compress.h',
        'decompress/huf_decompress.c',
        'decompress/zstd_ddict.c',
        'decompress/zstd_ddict.h',
        'decompress/zstd_decompress.c',
        'decompress/zstd_decompress_block.c',
        'decompress/zstd_decompress_block.h',
        'decompress/zstd_decompress_internal.h',
        'deprecated/zbuff.h',
        'deprecated/zbuff_common.c',
        'deprecated/zbuff_compress.c',
        'deprecated/zbuff_decompress.c',
        'dictBuilder/cover.c',
        'dictBuilder/cover.h',
        'dictBuilder/divsufsort.c',
        'dictBuilder/divsufsort.h',
        'dictBuilder/fastcover.c',
        'dictBuilder/zdict.c',
        'dictBuilder/zdict.h',
    ]],
    includes = [
        'lib',
        'lib/common',
        'lib/compress',
        'lib/decompress',
        'lib/dictBuilder',
        'lib/deprecated',
    ],
    strip_include_prefix = "lib",
)
