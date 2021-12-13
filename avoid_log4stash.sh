#!/usr/bin/qsh
# ---------------------------------------------------------------------------------------------------
# Important notes
# ---------------------------------------------------------------------------------------------------
#
# - Please see avoid_log4shell.sh for the current version! When I first published, I borked up the name,
#   but I am leaving this here in case anyone references it. OOPS!!
#   The properly-named version is at https://github.com/ThePrez/IBMiOSS-utils/blob/master/avoid_log4shell.sh
# 
# - This script comes with no form of warranty or guarantee. Please reference below license. 
# 
# - This script is intended to serve as a part of a containment and mitigation activity for the
#   Log4Stash vulnerability. IT IS NOT A COMPLETE FIX! Some versions of log4j will still be exposed.
#   See https://www.fastly.com/blog/digging-deeper-into-log4shell-0day-rce-exploit-found-in-log4j
#   for more details
# 
# - This script assumes you are not utilizing JAVA_TOOL_OPTIONS to set Java options today. This
#   will overwrite the value if you are setting the environment variable system-wide.
#
# ---------------------------------------------------------------------------------------------------
# License
# ---------------------------------------------------------------------------------------------------
#
# Copyright (c) 2021 Jesse Gorzinski
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# ---------------------------------------------------------------------------------------------------
# Instructions
# ---------------------------------------------------------------------------------------------------
# If you have wget, you can do the following to download and run:
#      wget https://github.com/ThePrez/IBMiOSS-utils/raw/master/avoid_log4shell.sh
#      chmod +x ./avoid_log4shell.sh
#      ./avoid_log4shell.sh
#
# Otherwise, download https://github.com/ThePrez/IBMiOSS-utils/raw/master/avoid_log4stash.sh manually and
# place in IFS and run:
#      chmod +x ./avoid_log4shell.sh && ./avoid_log4shell.sh
# 
# Otherwise, as a last resort, just copy/paste the non-commented lines in this file.



touch -C 37 /QIBM/UserData/Java400/SystemDefault.properties
echo 'log4j2.formatMsgNoLookups=true' >> /QIBM/UserData/Java400/SystemDefault.properties

# in case you're using a non-JV1 Java
system -kpieb "ADDENVVAR ENVVAR(JAVA_TOOL_OPTIONS) VALUE('-Dlog4j2.formatMsgNoLookups=true') REPLACE(*YES) LEVEL(*SYS)"
