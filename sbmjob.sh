#!/QOpenSys/usr/bin/sh
JOBNAME=$(echo "$1" | sed 's/[^a-zA-Z0-9]//g' | cut -c-10) 
SBMJOB_OPTS="JOB($JOBNAME) $SBMJOB_OPTS" 
exec /QOpenSys/usr/bin/system -kpiveO "SBMJOB CMD(CALL PGM(QP2SHELL2) PARM('/QOpenSys/usr/bin/sh' '-c' 'cd $(pwd) && env && exec $*')) CPYENVVAR(*YES) PRTDEV(*USRPRF) ALWMLTTHD(*YES) $SBMJOB_OPTS"
