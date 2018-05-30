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

def flatten_config(optional, config_vars, prefix):
    nested_config_srcs = [
        srcs for key, srcs in optional.items()
        if '#define CONFIG_{} 1'.format(key) in config_vars]

    flattened_srcs = [
        inner for outer in nested_config_srcs for inner in outer]

    result = dict([(prefix + x, None) for x in flattened_srcs]).keys()
    return result
