#!/bin/bash


sysid=sys
syspwd=tmpsyspwd
dbfroot='/oracle-2017-spring/'

echo "How many user delete? : "
read usercount
count=0
while [ "$count" -lt "$usercount" ]
do
read user < delete_ID

# if [ "$ID" = "" ]; then
# exit
# fi


sqlplus $sysid/$syspwd as sysdba << EOF
whenever sqlerror exit sql.sqlcode;

DROP USER $user CASCADE;
DROP TABLESPACE $user;

exit;
EOF

echo "***********************$user deleted********************" 
echo "********************************************************" 
echo "********************************************************" 
echo "********************************************************" 
echo "********************************************************" 

count=$(($count+1))

rm $dbfroot$user.dbf

sed '1d' delete_ID >> delete_ID2
rm -f delete_ID
mv delete_ID2 delete_ID

done
