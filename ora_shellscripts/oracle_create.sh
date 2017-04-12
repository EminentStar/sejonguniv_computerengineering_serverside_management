#!/bin/bash


sysid=sys
syspwd=tmpsyspwd
dbfroot='/oracle-2017-spring/'

echo "How many user add? : "
read usercount
count=0
while [ "$count" -lt "$usercount" ]
do

read user < addID

sqlplus $sysid/$syspwd as sysdba << EOF
whenever sqlerror exit sql.sqlcode;

CREATE TABLESPACE $user 
	datafile '$dbfroot$user.dbf' 
	size 50m 
	autoextend off 
	extent management local;

CREATE USER $user 
	IDENTIFIED BY $user 
	DEFAULT  TABLESPACE $user ; 

ALTER USER $user QUOTA UNLIMITED ON $user; 
GRANT CONNECT, RESOURCE TO $user;

exit;
EOF

echo "[$user]**********************user and table space created******************"
echo "**************************************************************"
echo "**************************************************************"
echo "**************************************************************"
echo "**************************************************************"

count=$(($count+1))


sed '1d' addID >> addID2
rm -f addID
mv addID2 addID

done
