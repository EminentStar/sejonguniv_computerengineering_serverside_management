clear

#MYSQL Root password
#PW="404myadmin#"

echo "Delete student accounts"
echo "How many user backup and delete? : "
read usercount

#echo "The year and semester created: 예)2006_1 : "
#read year

#mkdir /home/backup/class_backup/"$year"

count=0
while [ "$count" -lt "$usercount" ]
do

#echo "User account : "
read ID < delete_ID

if [ "$ID" = "" ]; then
exit
fi
#
#echo -n "
#The id of User : $ID
#The year and semester created : $year
# Press ENTER if correct, otherwise, Press CTRL+C"
#read imsy


#echo "Back up class account"
#tar cvfpz /home/backup/class_backup/"$year"/"$ID".tar.gz /home/account/class/"$ID"

echo "Deleting Account"
userdel -r "$ID"



count=$(($count+1))
sed '1d' delete_ID >> delete_ID2
rm -f delete_ID
mv delete_ID2 delete_ID


done

