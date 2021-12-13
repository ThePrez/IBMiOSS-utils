#!/QOpenSys/usr/bin/sh
touch /QIBM/UserData/Java400/SystemDefault.properties
echo 'log4j2.formatMsgNoLookups=true' >> /QIBM/UserData/Java400/SystemDefault.properties
# in case you're using a non-JV1 Java
system -kpieb "ADDENVVAR ENVVAR(JAVA_TOOL_OPTIONS) VALUE('-Dlog4j2.formatMsgNoLookups=true') REPLACE(*YES) LEVEL(*SYS)"
