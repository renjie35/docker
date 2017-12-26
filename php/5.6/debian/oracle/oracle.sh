# vi /etc/profile.d/oracle.sh
export ORACLE_HOME=/usr/lib/oracle/12.2/client64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib
export TNS_ADMIN=$ORACLE_HOME/network/admin
export PATH=$PATH:$ORACLE_HOME/bin
export NLS_LANG="SIMPLIFIED CHINESE_CHINA.ZHS16GBK"