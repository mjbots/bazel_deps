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

load("@com_github_mjbots_bazel_deps//tools/workspace:autoconf_config.bzl",
     "autoconf_config", "autoconf_standard_defines")
load("@com_github_mjbots_bazel_deps//tools/workspace:template_file.bzl",
     "template_file")
load("@com_github_mjbots_bazel_deps//tools/workspace:generate_file.bzl",
     "generate_file")

package(default_visibility = ["//visibility:public"])

STATIC_MODULES = {
    "posix": ["posixmodule.c"],
    "errno": ["errnomodule.c"],
    "pwd": ["pwdmodule.c"],
    "_sre": ["_sre.c"],
    "_codecs": ["_codecsmodule.c"],
    "_weakref": ["_weakref.c"],
    "_functools": ["_functoolsmodule.c"],
    "_operator": ["_operator.c"],
    "_collections": ["_collectionsmodule.c"],
    "itertools": ["itertoolsmodule.c"],
    "atexit": ["atexitmodule.c"],
    "_signal": ["signalmodule.c"],
    "_stat": ["_stat.c"],
    "time": ["timemodule.c"],
    "_locale": ["_localemodule.c"],
    "_io": ["_io/_iomodule.c", "_io/iobase.c", "_io/fileio.c", "_io/bytesio.c", "_io/bufferedio.c", "_io/textio.c", "_io/stringio.c"],
    "zipimport": ["zipimport.c"],
    "faulthandler": ["faulthandler.c"],
    "_tracemalloc": ["_tracemalloc.c", "hashtable.c"],
    "_symtable": ["symtablemodule.c"],
    "_thread": ["_threadmodule.c"],
    "xxsubtype": ["xxsubtype.c"],

    "array": ["arraymodule.c"],
    "cmath": ["cmathmodule.c", "_math.c"],
    "math": ["mathmodule.c", "_math.c"],
    "_struct": ["_struct.c"],
    # "_weakref": ["_weakref.c"],
    "_random": ["_randommodule.c"],
    # "_elementtree": ["_elementtree.c"],
    "_pickle": ["_pickle.c"],
    "_datetime": ["_datetimemodule.c"],
    "_bisect": ["_bisectmodule.c"],
    "_heapq": ["_heapqmodule.c"],
    "_asyncio": ["_asynciomodule.c"],
    "unicodedata": ["unicodedata.c"],
    "fcntl": ["fcntlmodule.c"],
    "spwd": ["spwdmodule.c"],
    "grp": ["grpmodule.c"],
    "select": ["selectmodule.c"],
    "mmap": ["mmapmodule.c"],
    "_csv": ["_csv.c"],
    "_socket": ["socketmodule.c"],
    # "_crypt": ["_cryptmodule.c"],
    "_md5": ["md5module.c"],
    "_sha1": ["sha1module.c"],
    "_sha256": ["sha256module.c"],
    "_sha512": ["sha512module.c"],
    "_sha3": ["_sha3/sha3module.c"],
    "_blake2": ["_blake2/blake2module.c", "_blake2/blake2b_impl.c", "_blake2/blake2s_impl.c"],
    "binascii": ["binascii.c"],
    "zlib": ["zlibmodule.c"],
    "_multiprocessing": ["_multiprocessing/multiprocessing.c", "_multiprocessing/semaphore.c"],
    "_posixsubprocess": ["_posixsubprocess.c"],
}

# TODO(jpieper): If modules are compiled as shared objects, something
# is broken and the import machinery can't find them yet.  Thus we
# just compile everything in statically for now.
SHARED_MODULES = {
}

cc_library(
    name = "headers",
    hdrs = glob(["Include/*.h"]) + ["Include/pyconfig.h"],
    includes = ["Include"],
)

cc_library(
    name = "lib",
    srcs = glob([
        "Objects/*.c",
        "Objects/**/*.h",
        "Parser/*.c",
        "Parser/*.h",
        "Python/*.c",
        "Python/**/*.h",
        "Modules/**/*.h",
    ], exclude = [
        "Objects/typeslots.inc",
        "Parser/parsetok_pgen.c",
        "Parser/tokenizer_pgen.c",
        "Parser/pgenmain.c",
        "Python/dynload_aix.c",
        "Python/dynload_dl.c",
        "Python/dynload_hpux.c",
        "Python/dynload_next.c",
        "Python/dynload_stub.c",
        "Python/dynload_win.c",
        "Python/sigcheck.c",
        "Python/strdup.c",
    ]) + [
        "Modules/config.c",
        "Modules/getpath.c",
        "Modules/main.c",
        "Modules/gcmodule.c",
        "Modules/getbuildinfo.c",
    ] + dict([("Modules/" + item, True) for sublist in STATIC_MODULES.values()
              for item in sublist]).keys(),
    textual_hdrs = [
        "Objects/typeslots.inc",
        "Parser/parsetok.c",
        "Parser/tokenizer.c",
    ] + glob([
        "Modules/_sha3/kcp/**",
        "Modules/_blake2/impl/**",
    ]),
    copts = [
        "-DPy_BUILD_CORE",
        "-DSOABI='\"cpython-36m-x86_64-linux-gnu\"'",
        "-DNDEBUG",
        "-DVERSION='\"3.6\"'",
        "-DPREFIX='\"\"'",
        "-DEXEC_PREFIX='\"\"'",
        "-DVPATH='\"\"'",
        "-DPYTHONPATH='\":\"'",
        "-DABIFLAGS='\"m\"'",
    ],
    deps = [
        ":headers",
        "@bzip2",
        "@expat",
        "@zlib",
    ],
)

ALL_STDLIB = glob(["Lib/**/*.py"])

genrule(
    name = "move_stdlib",
    srcs = ALL_STDLIB,
    outs = ["lib/python3.6/" + x[4:] for x in ALL_STDLIB],
    cmd = "SRC=($(SRCS)) OUT=($(OUTS)); for (( i=0; i < $${#SRC[*]}; ++i)); do in=$${SRC[$$i]}; out=$${OUT[$$i]}; cp $$in $$out 1>&2; done"
)

[cc_binary(
    name = "lib/python3.6/lib-dynload/" + item + ".cpython-36m-unknown.so",
    srcs = ["Modules/" + x for x in srcs] + glob(["**/*.h"]),
    linkshared = True,
    deps = [":lib"],
    linkopts = ["-lpthread", "-ldl", "-lutil",],
) for item, srcs in SHARED_MODULES.items()]

filegroup(
    name = "modules",
    srcs = ["lib/python3.6/lib-dynload/" + item + ".cpython-36m-unknown.so"
            for item in SHARED_MODULES.keys()],
)

cc_binary(
    name = "python",
    srcs = [
        "Programs/python.c",
    ],
    deps = [
        ":lib",
    ],
    linkopts = [
        "-lpthread",
        "-ldl",
        "-lutil",
    ],
    data = [
        ":modules",
        ":move_stdlib",
        "lib/python3.6/_sysconfigdata_m_unknown_.py",
    ],
)

template_file(
    name = "Modules/config.c",
    src = "Modules/config.c.in",
    substitutions = {
        "/* -- ADDMODULE MARKER 1 -- */": "\n".join(
            ["extern PyObject* PyInit_{}(void);".format(item)
             for item in STATIC_MODULES.keys()]) + """

/* -- ADDMODULE MARKER 1 -- */
        """,
        "/* -- ADDMODULE MARKER 2 -- */": "\n".join(
            ["{{\"{item}\", PyInit_{item}}},".format(item=item)
             for item in STATIC_MODULES.keys()]) + """

/* -- ADDMODULE MARKER 2 -- */
        """
    },
)

generate_file(
    name = "lib/python3.6/_sysconfigdata_m_unknown_.py",
    content = "build_time_vars = {}",
)

autoconf_config(
    name = "Include/pyconfig.h",
    src = "pyconfig.h.in",
    package = "python",
    version = "3.6.5",
    defines = autoconf_standard_defines + [
        "DOUBLE_IS_LITTLE_ENDIAN_IEEE754",
        "ENABLE_IPV6",
        "PY_FORMAT_SIZE_T=\"z\"",
        "RETSIGTYPE=void",
        "USE_INLINE",
        "WITH_DOC_STRINGS",
        "WITH_THREAD",
        "_FILE_OFFSET_BITS=64",
        "_LARGEFILE_SOURCE",
    ],
)
