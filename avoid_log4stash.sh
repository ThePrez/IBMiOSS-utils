#!/QOpenSys/usr/bin/sh
# ---------------------------------------------------------------------------------------------------
# Important notes
# ---------------------------------------------------------------------------------------------------
#
# Please see avoid_log4shell.sh for the current version! When I first published, I borked up the name,
# but I am leaving this here in case anyone references it. OOPS!!
# The properly-named version is at https://github.com/ThePrez/IBMiOSS-utils/blob/master/avoid_log4shell.sh
#
# This script assumes you are not utilizing JAVA_TOOL_OPTIONS to set Java options today. Also, this
# script comes with no warranty (see license for details).
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



touch /QIBM/UserData/Java400/SystemDefault.properties
echo 'log4j2.formatMsgNoLookups=true' >> /QIBM/UserData/Java400/SystemDefault.properties

# in case you're using a non-JV1 Java
system -kpieb "ADDENVVAR ENVVAR(JAVA_TOOL_OPTIONS) VALUE('-Dlog4j2.formatMsgNoLookups=true') REPLACE(*YES) LEVEL(*SYS)"
