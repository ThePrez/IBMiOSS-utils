#!/QOpenSys/usr/bin/sh
QIBM_USE_DESCRIPTOR_STDIO=N
export QIBM_USE_DESCRIPTOR_STDIO
ILE_PATH=$PATH
export ILE_PATH
ILE_LIBPATH=$LIBPATH
export ILE_LIBPATH
JOBNAME=$(echo "$1" | sed 's/[^a-zA-Z0-9]//g' | cut -c-10) 
SBMJOB_OPTS="JOB($JOBNAME) $SBMJOB_OPTS" 
exec /QOpenSys/usr/bin/system -kpiveO "SBMJOB CMD(CALL PGM(QP2SHELL2) PARM('/QOpenSys/usr/bin/sh' '-c' 'cd $(pwd) && env && exec $*')) CPYENVVAR(*YES) PRTDEV(*USRPRF) ALWMLTTHD(*YES) $SBMJOB_OPTS"
