#!/usr/bin/env python
"""
Test to get nvidia binaries and libraries

Copyright 2017 LIP
Author: Mario David <mariojmdavid@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""
import sys
import os
import stat
import string
import re
import json
import subprocess
import time
import pwd
import grp
import platform

if __name__ == "__main__":
    bin_dir = '/usr/bin'
    etc_dir = '/etc'
    lib_dir_host = '/usr/lib/x86_64-linux-gnu'   # libdir for debian/ubuntu host OS
    lib_dir_image = '/usr/lib/x86_64-linux-gnu'  # libdir for debian/ubuntu docker OS
    os_type = 'debian'  # default OS type of host
    list_etc = ['vulkan/icd.d/nvidia_icd.json', 'OpenCL/vendors/nvidia.icd']

    # TODO: try except
    os_file = open('/etc/os-release', 'r')
    for line in os_file:
        line = line.rstrip()
        if re.search('^ID_LIKE=', line):
            (dummy, os_type) = line.split('=')
            print os_type

    if re.search('rhel', os_type):
        lib_dir_host = '/usr/lib64'

    print lib_dir_host

    with open('container.json') as fp:
        cont_json = json.load(fp)
    print cont_json['config']['Env']
