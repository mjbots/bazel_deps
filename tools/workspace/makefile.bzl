# -*- python -*-

# Copyright 2018-2019 Josh Pieper, jjp@pobox.com.
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

_VALID_IDENTIFIERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_$()-"

def _is_valid_identifier(name):
    for i in range(len(name)):
        x = name[i]
        if x not in _VALID_IDENTIFIERS:
            return False
    return True

def _search_variable(line):
    line = line.strip()
    if not '=' in line:
        return None
    if line.startswith('#'):
        return None

    maybe_var, maybe_value = [x.strip() for x in line.split('=', 1)]

    result = {}
    if maybe_var.endswith('+'):
        maybe_var = maybe_var[:-1].strip()
        result['concat'] = True
    else:
        result['concat'] = False

    if not _is_valid_identifier(maybe_var):
        return None

    result['name'] = maybe_var
    result['value'] = None

    stripped_value = maybe_value.strip(" \\")
    if len(stripped_value):
        result['value'] = stripped_value

    return result


def makefile_parse(contents):
    """Parse variable like entities from Makefiles.

    Returns a dictionary mapping make variables to their contents.
    """
    result = {}

    current_name = None
    current_list = None

    for line in contents.split("\n"):
        hash = line.find('#')
        if hash != -1:
            line = line[0:hash]

        if current_name:
            current_list += line.strip(" \\").split(' ')
        else:
            match = _search_variable(line)
            if match:
                current_name = match['name']
                if match['concat']:
                    current_list = result.get(current_name, [])
                else:
                    current_list = []
                if match['value']:
                    current_list += match['value'].split(' ')

        if current_name:
            if not line.endswith("\\"):
                result[current_name] = [
                    x.strip() for x in current_list
                    if x.strip() != "" and x.strip() != "$(NULL)"]
                current_name = None
                current_list = None

    return result

def _format_var(key, var_list):
    return (
        "{key} = [\n".format(key=key) +
        ''.join(["\"{item}\",\n".format(item=item) for item in var_list]) +
        "]\n")

def format_makefile(data):
    return '\n'.join([_format_var(key, var)
                      for key, var in data.items()])
