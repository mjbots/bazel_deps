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

cc_library(
    name = "log4cpp",
    hdrs = ["include/log4cpp/" + x for x in [
        "AbortAppender.hh",
        "Appender.hh",
        "AppendersFactory.hh",
        "AppenderSkeleton.hh",
        "BasicConfigurator.hh",
        "BasicLayout.hh",
        "BufferingAppender.hh",
        "Category.hh",
        "CategoryStream.hh",
        "config-MinGW32.h",
        "config-openvms.h",
        "Configurator.hh",
        # "config-win32.h",
        # "config-win32-stlport-boost.h",
        "convenience.h",
        "DailyRollingFileAppender.hh",
        "Export.hh",
        "FactoryParams.hh",
        "FileAppender.hh",
        "Filter.hh",
        "FixedContextCategory.hh",
        "HierarchyMaintainer.hh",
        "IdsaAppender.hh",
        "LayoutAppender.hh",
        "Layout.hh",
        "LayoutsFactory.hh",
        "LevelEvaluator.hh",
        "LoggingEvent.hh",
        "Manipulator.hh",
        "NDC.hh",
        "NTEventLogAppender.hh",
        "OstreamAppender.hh",
        "PassThroughLayout.hh",
        "PatternLayout.hh",
        "Portability.hh",
        "Priority.hh",
        "PropertyConfigurator.hh",
        "RollingFileAppender.hh",
        "SimpleConfigurator.hh",
        "SimpleLayout.hh",
        "SmtpAppender.hh",
        "StringQueueAppender.hh",
        "SyslogAppender.hh",
        "threading/BoostThreads.hh",
        "threading/DummyThreads.hh",
        "threading/MSThreads.hh",
        "threading/OmniThreads.hh",
        "threading/PThreads.hh",
        "threading/Threading.hh",
        "TimeStamp.hh",
        "TriggeringEventEvaluatorFactory.hh",
        "TriggeringEventEvaluator.hh",
        "config.h",
    ]],
    textual_hdrs = [
        "src/snprintf.c",
    ],
    srcs = ["src/" + x for x in [
        "AbortAppender.cpp",
        "Appender.cpp",
        "AppendersFactory.cpp",
        "AppenderSkeleton.cpp",
        "BasicConfigurator.cpp",
        "BasicLayout.cpp",
        "BufferingAppender.cpp",
        "Category.cpp",
        "CategoryStream.cpp",
        "Configurator.cpp",
        "DailyRollingFileAppender.cpp",
        "DllMain.cpp",
        "DummyThreads.cpp",
        "FactoryParams.cpp",
        "FileAppender.cpp",
        "Filter.cpp",
        "FixedContextCategory.cpp",
        "HierarchyMaintainer.cpp",
        "IdsaAppender.cpp",
        "LayoutAppender.cpp",
        "LayoutsFactory.cpp",
        "LevelEvaluator.cpp",
        "Localtime.cpp",
        "Localtime.hh",
        "LoggingEvent.cpp",
        "Manipulator.cpp",
        "MSThreads.cpp",
        "NDC.cpp",
        "NTEventLogAppender.cpp",
        "OmniThreads.cpp",
        "OstreamAppender.cpp",
        "PassThroughLayout.cpp",
        "PatternLayout.cpp",
        "PortabilityImpl.cpp",
        "PortabilityImpl.hh",
        "Priority.cpp",
        "Properties.cpp",
        "Properties.hh",
        "PropertyConfigurator.cpp",
        "PropertyConfiguratorImpl.cpp",
        "PropertyConfiguratorImpl.hh",
        "PThreads.cpp",
        "RollingFileAppender.cpp",
        "SimpleConfigurator.cpp",
        "SimpleLayout.cpp",
        "SmtpAppender.cpp",
        "StringQueueAppender.cpp",
        "StringUtil.cpp",
        "StringUtil.hh",
        "SyslogAppender.cpp",
        "TimeStamp.cpp",
        "TriggeringEventEvaluatorFactory.cpp",
    ]],
    includes = ["include"],
    copts = [
        "-Wno-deprecated-declarations",
        "-Wno-unused-variable",
        "-Wno-parentheses",
        "-Wno-unused-parameter",
    ],
    defines = [
        "LOG4CPP_HAVE_SSTREAM",
    ],
)

autoconf_config(
    name = "include/log4cpp/config.h",
    src = "include/config.h.in",
    package = "log4cpp",
    version = "1.1.3",
    defines = autoconf_standard_defines + [
        "DISABLE_SMTP",
        "DISABLE_REMOTE_SYSLOG",

        # TODO(jjp@pobox.com): log4cpp crashes on exit with threading
        # enabled and I haven't decided it is worth to fix it yet.
        #
        # "HAVE_THREADING",
        # "USE_PTHREADS",
    ],
    prefix = "LOG4CPP_",
)
