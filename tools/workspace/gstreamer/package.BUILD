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
load("@com_github_mjbots_bazel_deps//tools/workspace:autoconf_config.bzl",
     "autoconf_config", "autoconf_standard_defines")

package(default_visibility = ["//visibility:public"])

LIBGSTREAMER_SOURCES = ["gst/" + x for x in [
    "gstregistrybinary.c",
    "gst.c",
    "gstobject.c",
    "gstallocator.c",
    "gstbin.c",
    "gstbuffer.c",
    "gstbufferlist.c",
    "gstbufferpool.c",
    "gstbus.c",
    "gstcaps.c",
    "gstcapsfeatures.c",
    "gstchildproxy.c",
    "gstclock.c",
    "gstcontext.c",
    "gstcontrolbinding.c",
    "gstcontrolsource.c",
    "gstdatetime.c",
    "gstdebugutils.c",
    "gstdevice.c",
    "gstdevicemonitor.c",
    "gstdeviceprovider.c",
    "gstdeviceproviderfactory.c",
    "gstdynamictypefactory.c",
    "gstelement.c",
    "gstelementfactory.c",
    "gsterror.c",
    "gstevent.c",
    "gstformat.c",
    "gstghostpad.c",
    "gstinfo.c",
    "gstiterator.c",
    "gstatomicqueue.c",
    "gstmessage.c",
    "gstmeta.c",
    "gstmemory.c",
    "gstminiobject.c",
    "gstpad.c",
    "gstpadtemplate.c",
    "gstparamspecs.c",
    "gstpipeline.c",
    "gstplugin.c",
    "gstpluginfeature.c",
    "gstpluginloader.c",
    "gstpoll.c",
    "gstpreset.c",
    "gstprotection.c",
    "gstquark.c",
    "gstquery.c",
    "gstregistry.c",
    "gstregistrychunks.c",
    "gstpromise.c",
    "gstsample.c",
    "gstsegment.c",
    "gststreamcollection.c",
    "gststreams.c",
    "gststructure.c",
    "gstsystemclock.c",
    "gsttaglist.c",
    "gsttagsetter.c",
    "gsttask.c",
    "gsttaskpool.c",
    "gsttoc.c",
    "gsttocsetter.c",
    "gsttracer.c",
    "gsttracerfactory.c",
    "gsttracerrecord.c",
    "gsttracerutils.c",
    "gsttypefind.c",
    "gsttypefindfactory.c",
    "gsturi.c",
    "gstutils.c",
    "gstvalue.c",
    "gstparse.c",
]]

PRINTF_SOURCES = ["gst/printf/" + x for x in [
    "asnprintf.c",
    "printf-args.c",
    "printf-args.h",
    "printf-parse.c",
    "printf-parse.h",
    "vasnprintf.c",
    "vasnprintf.h",
    "printf.c",
    "printf.h",
    "printf-extension.c",
    "printf-extension.h",
    "gst-printf.h",
]]

cc_library(
    name = "gst",
    copts = [
        "-I$(GENDIR)/external/gstreamer/gstprivate",
        "-Iexternal/gstreamer/gst",
        "-I$(GENDIR)/external/gstreamer/gst",
        "-DGST_EXPORTS",
        "-DG_LOG_DOMAIN=g_log_domain_gstreamer",
        "-DGST_DISABLE_DEPRECATED",
        "-DHAVE_CONFIG_H",
        "-D_GNU_SOURCE",
        "-Wno-int-conversion",
        "-Wno-unused-variable",
        "-Wno-implicit-function-declaration",
    ],
    deps = [
        "@glib//:glib",
        ":parse",
    ],
    srcs = PRINTF_SOURCES + LIBGSTREAMER_SOURCES + [
        "gstprivate/config.h",
        "gst/gstenumtypes.c",
    ],
    hdrs = glob(["gst/*.h"]) + [
        "gst/gstconfig.h",
        "gst/gstversion.h",
        "gst/gstenumtypes.h",
    ],
    includes = ["."],
    linkopts = [
        "-ldl",
    ],
)

cc_library(
    name = "genheaders",
    hdrs = [
        "gst/gstconfig.h",
        "gst/gstenumtypes.h",
        "gst/gstversion.h",
    ],
    includes = ["."],
)

cc_library(
    name = "parse",
    hdrs = [
        "gst/parse/grammar.tab.h",
        "gst/parse/parse_lex.h",
    ],
    srcs = [
        "gst/parse/grammar.tab.c",
        "gst/parse/lex.priv_gst_parse_yy.c",
        "gst/parse/types.h",
        "gstprivate/config.h",
    ] + glob(["gst/*.h"]),
    textual_hdrs = [
        # We include this here for seemingly no good reason.  There
        # exist relative include headers that use ".." from the
        # "gst/parse" directory.  bazel sticks generated files in a
        # parallel structure, but won't resolve a relative include
        # unless the root actually exists.  Thus we include this file
        # to ensure a "gst/parse" directory exists so that gcc will
        # reference relative to it.
        "gst/parse/grammar.y",
    ],
    copts = [
        "-I$(GENDIR)/external/gstreamer/gstprivate",
        "-Iexternal/gstreamer/gstprivate",
        "-I$(GENDIR)/external/gstreamer/gst/parse",
        "-Iexternal/gstreamer/gst/parse",
        "-DGST_EXPORTS",
        "-DHAVE_CONFIG_H",
        "-DYYMALLOC=g_malloc",
        "-DYYFREE=g_free",
    ],
    deps = ["@glib", ":genheaders"],
)

genrule(
    name = "bison_parser",
    outs = ["gst/parse/grammar.tab.c", "gst/parse/grammar.tab.h"],
    srcs = ["gst/parse/grammar.y"],
    cmd = (
        'bison -d -v -ppriv_gst_parse_yy $< ' +
        '-o $(location gst/parse/grammar.tab.c) && ' +
        'mv $(location gst/parse/grammar.tab.c) $(location gst/parse/grammar.tab.c)_tmp && ' +
        'echo "#ifdef HAVE_CONFIG_H" > $(location gst/parse/grammar.tab.c) && ' +
        'echo "#include <config.h>" >> $(location gst/parse/grammar.tab.c) && ' +
        'echo "#endif" >> $(location gst/parse/grammar.tab.c) && ' +
        'cat $(location gst/parse/grammar.tab.c)_tmp >> $(location gst/parse/grammar.tab.c)'
    ),
)

genrule(
    name = "flex_lexer",
    outs = [
        "gst/parse/lex.priv_gst_parse_yy.c",
        "gst/parse/parse_lex.h",
    ],
    srcs = ["gst/parse/parse.l", "gst/parse/grammar.tab.h"],
    cmd = (
        'flex --header-file=$(location gst/parse/parse_lex.h) ' +
        ' -Ppriv_gst_parse_yy -o $(location gst/parse/lex.priv_gst_parse_yy.c) $(SRCS) && ' +
        'mv $(location gst/parse/lex.priv_gst_parse_yy.c) $(location gst/parse/lex.priv_gst_parse_yy.c)_tmp && ' +
        'echo "#ifdef HAVE_CONFIG_H" > $(location gst/parse/lex.priv_gst_parse_yy.c) && ' +
        'echo "#include <config.h>" >> $(location gst/parse/lex.priv_gst_parse_yy.c) && ' +
        'echo "#endif" >> $(location gst/parse/lex.priv_gst_parse_yy.c) && ' +
        '{ grep -q priv_gst_parse_yyget_column $(location gst/parse/parse_lex.h) || ' +
        '{ echo \'int priv_gst_parse_yyget_column  (void * yyscanner);\' >> $(location gst/parse/lex.priv_gst_parse_yy.c) && ' +
        'echo \'void priv_gst_parse_yyset_column (int column_no , void * yyscanner);\' >> $(location gst/parse/lex.priv_gst_parse_yy.c); }; } && ' +
        'cat $(location gst/parse/lex.priv_gst_parse_yy.c)_tmp >> $(location gst/parse/lex.priv_gst_parse_yy.c)'
    ),
)


GST_HEADERS = ["gst/" + x for x in [
    "gst.h",
    "glib-compat.h",
    "gstobject.h",
    "gstallocator.h",
    "gstbin.h",
    "gstbuffer.h",
    "gstbufferlist.h",
    "gstbufferpool.h",
    "gstbus.h",
    "gstcaps.h",
    "gstcapsfeatures.h",
    "gstchildproxy.h",
    "gstclock.h",
    "gstcompat.h",
    "gstcontext.h",
    "gstcontrolbinding.h",
    "gstcontrolsource.h",
    "gstdatetime.h",
    "gstdebugutils.h",
    "gstelement.h",
    "gstelementmetadata.h",
    "gstdevice.h",
    "gstdeviceprovider.h",
    "gstdeviceproviderfactory.h",
    "gstdynamictypefactory.h",
    "gstelementfactory.h",
    "gsterror.h",
    "gstevent.h",
    "gstformat.h",
    "gstghostpad.h",
    "gstdevicemonitor.h",
    "gstinfo.h",
    "gstiterator.h",
    "gstatomicqueue.h",
    "gstmacros.h",
    "gstmessage.h",
    "gstmeta.h",
    "gstmemory.h",
    "gstminiobject.h",
    "gstpad.h",
    "gstpadtemplate.h",
    "gstparamspecs.h",
    "gstpipeline.h",
    "gstplugin.h",
    "gstpluginfeature.h",
    "gstpoll.h",
    "gstpreset.h",
    "gstprotection.h",
    "gstquery.h",
    "gstpromise.h",
    "gstsample.h",
    "gstsegment.h",
    "gststreamcollection.h",
    "gststreams.h",
    "gststructure.h",
    "gstsystemclock.h",
    "gsttaglist.h",
    "gsttagsetter.h",
    "gsttask.h",
    "gsttaskpool.h",
    "gsttoc.h",
    "gsttocsetter.h",
    "gsttracer.h",
    "gsttracerfactory.h",
    "gsttracerrecord.h",
    "gsttypefind.h",
    "gsttypefindfactory.h",
    "gsturi.h",
    "gstutils.h",
    "gstvalue.h",
    "gstregistry.h",
    "gstparse.h",
]]

genrule(
    name = "gstenumtypes_h",
    srcs = GST_HEADERS,
    outs = ["gst/gstenumtypes.h"],
    tools = ["@glib//:glib-mkenums"],
    cmd = (
        '$(location @glib//:glib-mkenums) ' +
        '--fhead "#ifndef __GST_ENUM_TYPES_H__\n#define __GST_ENUM_TYPES_H__\n\n#include <glib-object.h>\n#include <gst/gstconfig.h>\n\nG_BEGIN_DECLS\n" ' +
        '--fprod "\n/* enumerations from \\"@filename@\\" */\n" ' +
        '--vhead "GST_API GType @enum_name@_get_type (void);\n#define GST_TYPE_@ENUMSHORT@ (@enum_name@_get_type())\n" ' +
        '--ftail "G_END_DECLS\n\n#endif /* __GST_ENUM_TYPES_H__ */" ' +
        ' $(SRCS) > $@'),
)

genrule(
    name = "gstenumtypes_c",
    srcs = GST_HEADERS,
    outs = ["gst/gstenumtypes.c"],
    tools = ["@glib//:glib-mkenums"],
    cmd = (
        '$(location @glib//:glib-mkenums) ' +
        '--fhead "#include \\"gst_private.h\\"\n#include <gst/gst.h>\n#define C_ENUM(v) ((gint) v)\n#define C_FLAGS(v) ((guint) v)\n " ' +
        '--fprod "\n/* enumerations from \\"@filename@\\" */" ' +
        '--vhead "GType\n@enum_name@_get_type (void)\n{\n  static gsize id = 0;\n  static const G@Type@Value values[] = {" ' +
        '--vprod "    { C_@TYPE@(@VALUENAME@), \\"@VALUENAME@\\", \\"@valuenick@\\" }," ' +
        '--vtail "    { 0, NULL, NULL }\n  };\n\n  if (g_once_init_enter (&id)) {\n    GType tmp = g_@type@_register_static (\\"@EnumName@\\", values);\n    g_once_init_leave (&id, tmp);\n  }\n\n  return (GType) id;\n}" ' +
        ' $(SRCS) > $@'),
)

template_file(
    name = "gst/gstconfig.h",
    src = "gst/gstconfig.h.in",
    substitutions = {
        "@GST_DISABLE_GST_DEBUG_DEFINE@" : "/* #undef GST_DISABLE_GST_DEBUG */",
        "@GST_DISABLE_PARSE_DEFINE@" : "/* #undef GST_DISABLE_PARSE */",
        "@GST_DISABLE_REGISTRY_DEFINE@" : "/* #undef GST_DISABLE_REGISTRY */",
        "@GST_DISABLE_PLUGIN_DEFINE@" : "/* #undef GST_DISABLE_PLUGIN */",
        "@GSTCONFIG_BUILT_WITH_MSVC@" : "0",
    },
)

template_file(
    name = "gst/gstversion.h",
    src = "gst/gstversion.h.in",
    substitutions = {
        "@GST_VERSION_MAJOR@" : "1",
        "@GST_VERSION_MINOR@" : "14",
        "@GST_VERSION_MICRO@" : "1",
        "@GST_VERSION_NANO@" : "0",
    },
)

autoconf_config(
    name = "gstprivate/config.h",
    src = "config.h.in",
    package = "gstreamer",
    version = "1.14.1",
    defines = autoconf_standard_defines + [
        "HOST_CPU=\"x86_64\"",
        "ENABLE_SUBUNIT=0",
        "GETTEXT_PACKAGE=\"gstreamer-1.0\"",
        "GIO_LIBDIR=\"XXX\"",
        "GIO_MODULE_DIR=\"XXX\"",
        "GIO_PREFIX=\"XXX\"",
        "GST_API_VERSION=\"1.0\"",
        "GST_COMPLETION_HELPER_INSTALLED=\"XXX\"",
        "GST_DATADIR=\"XXX\"",
        "GST_FUNCTION=__PRETTY_FUNCTION__",
        "GST_LEVEL_DEFAULT=GST_LEVEL_NONE",
        "GST_LICENSE=\"GPL\"",
        "GST_PACKAGE_NAME=\"gstreamer\"",
        "GST_PACKAGE_ORIGIN=\"unknown\"",
        "GST_PACKAGE_RELEASE_DATETIME=\"2018-05-17\"",
        "GST_PLUGIN_SCANNER_INSTALLED=\"XXX\"",
        "GST_PLUGIN_SCANNER_SUBDIR=\"XXX\"",
        "GST_PTP_HELPER_INSTALLED=\"XXX\"",
        "LIBDIR=\"XXX\"",
        "LOCALEDIR=\"XXX\"",
        "MEMORY_ALIGNMENT_MALLOC",
        "PLUGINDIR=\"XXX\"",
    ],
)

LIBGSTBASE_SOURCES = ["libs/gst/base/" + x for x in [
    "gstadapter.c",
    "gstaggregator.c",
    "gstbaseparse.c",
    "gstbasesink.c",
    "gstbasesrc.c",
    "gstbasetransform.c",
    "gstbitreader.c",
    "gstbytereader.c",
    "gstbytewriter.c",
    "gstcollectpads.c",
    "gstdataqueue.c",
    "gstflowcombiner.c",
    "gstpushsrc.c",
    "gstqueuearray.c",
    "gsttypefindhelper.c",
]]

cc_library(
    name = "libgstbase",
    deps = [":gst"],
    copts = [
        "-I$(GENDIR)/external/gstreamer/gstprivate",
        "-DHAVE_CONFIG_H",
    ],
    srcs = LIBGSTBASE_SOURCES,
    textual_hdrs = [
        "libs/gst/base/gstindex.c",
        "libs/gst/base/gstmemindex.c",
    ],
    hdrs = glob(["libs/gst/base/*.h"]),
    includes = ["libs"],
)

LIBGSTCONTROLLER_SOURCES = ["libs/gst/controller/" + x for x in [
    "gstargbcontrolbinding.c",
    "gstdirectcontrolbinding.c",
    "gsttimedvaluecontrolsource.c",
    "gstinterpolationcontrolsource.c",
    "gstproxycontrolbinding.c",
    "gsttriggercontrolsource.c",
    "gstlfocontrolsource.c",
    "controller-enumtypes.c",
]]

py_binary(
    name = "controller_mkenum",
    srcs = ["libs/gst/controller/controller_mkenum.py"],
)

CONTROLLER_MKENUM_HEADERS = ["libs/gst/controller/" + x for x in [
  'gstinterpolationcontrolsource.h',
  'gstlfocontrolsource.h',
]]

genrule(
    name = "gstcontroller_h",
    srcs = CONTROLLER_MKENUM_HEADERS,
    outs = ["libs/gst/controller/controller-enumtypes.h"],
    tools = [":controller_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :controller_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

genrule(
    name = "gstcontroller_c",
    srcs = CONTROLLER_MKENUM_HEADERS,
    outs = ["libs/gst/controller/controller-enumtypes.c"],
    tools = [":controller_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :controller_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

cc_library(
    name = "libgstcontroller",
    deps = [":gst"],
    copts = [
        "-I$(GENDIR)/external/gstreamer/gstprivate",
        "-Iexternal/gstreamer/libs/gst/controller",
        "-DHAVE_CONFIG_H",
    ],
    srcs = LIBGSTCONTROLLER_SOURCES,
    hdrs = ["libs/gst/controller/" + x for x in [
            "controller-enumtypes.h",
    ]] + glob(["libs/gst/controller/*.h"]),
    includes = ["libs"],
)

LIBGSTNET_SOURCES = ["libs/gst/net/" + x for x in [
    'gstnetaddressmeta.c',
    'gstnetclientclock.c',
    'gstnetcontrolmessagemeta.c',
    'gstnettimepacket.c',
    'gstnettimeprovider.c',
    'gstptpclock.c',
    'gstntppacket.c',
    'gstnetutils.c',
]]

cc_library(
    name = "libgstnet",
    deps = [":gst", ":libgstbase"],
    copts = [
        "-I$(GENDIR)/external/gstreamer/gstprivate",
        "-Iexternal/gstreamer/libs/gst/net",
        "-DHAVE_CONFIG_H",
    ],
    srcs = LIBGSTNET_SOURCES,
    hdrs = glob(["libs/gst/net/*.h"]),
    includes = ["libs"],
)

cc_library(
    name = "gstcoreelements",
    deps = [":gst", ":libgstbase"],
    copts = [
        "-I$(GENDIR)/external/gstreamer/gstprivate",
        "-DHAVE_CONFIG_H",
    ],
    srcs = glob([
        "plugins/elements/*.c",
        "plugins/elements/*.h",
    ]),
)

cc_library(
    name = "gstreamer",
    deps = [
        ":gst",
        ":libgstbase",
        ":libgstcontroller",
        ":libgstnet",
        ":gstcoreelements",
    ],
)
