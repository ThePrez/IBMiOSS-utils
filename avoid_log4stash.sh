#!/QOpenSys/usr/bin/sh
# ---------------------------------------------------------------------------------------------------
# No warranty, express or implied!
# 
# Also note that this script assumes you are not utilizing JAVA_TOOL_OPTIONS to set Java options today
# ---------------------------------------------------------------------------------------------------
# Instructions
# ---------------------------------------------------------------------------------------------------
# If you have wget, you can do the following to download and run:
#      wget https://github.com/ThePrez/IBMiOSS-utils/raw/master/avoid_log4stash.sh
#      chmod +x ./avoid_log4stash.sh
#      ./avoid_log4stash.sh
#
# Otherwise, download https://github.com/ThePrez/IBMiOSS-utils/raw/master/avoid_log4stash.sh manually and
# place in IFS and run:
#      chmod +x ./avoid_log4stash.sh && ./avoid_log4stash.sh
# 
# Otherwise, as a last resort, just copy/paste the non-commented lines in this file.
touch /QIBM/UserData/Java400/SystemDefault.properties
echo 'log4j2.formatMsgNoLookups=true' >> /QIBM/UserData/Java400/SystemDefault.properties
# in case you're using a non-JV1 Java
system -kpieb "ADDENVVAR ENVVAR(JAVA_TOOL_OPTIONS) VALUE('-Dlog4j2.formatMsgNoLookups=true') REPLACE(*YES) LEVEL(*SYS)"
