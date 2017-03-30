#!/bin/bash
clear

#account_root="/home/account/class"

echo "Create multiple general Users per Class"
echo "*************************************************"
echo ""
echo ""

#Class user
echo "Class account addition"
echo ""

echo "How many user add? : "
read usercount
echo "The name of default directory for Class?: "
read basicfolder
mkdir /home/account/class/"$basicfolder"

chgrp fac /home/account/class/"$basicfolder"

account_root=/home/account/class/"$basicfolder"
echo "Check the number of user added."
echo ""
tail  /etc/passwd | grep 5000
echo ""

echo "start userid? : "
read uid
echo "Input groupid : "
read gid
count=0
while [ "$count" -lt "$usercount" ]
do
#echo "사용자 계정 : "
read ID < addID

#echo "사용자 패스워드 : "
read PASS < addID

#echo "사용자 uid: "

if [ "$ID" = "" ]; then
exit
fi


#계정번호 중복확인 및 에러검출
USER_COUNT_number=`cat /etc/passwd | grep -w "$uid" | wc -l`
if [ "$USER_COUNT_number" -ge "1" ]; then
echo "The User's number is OVERLAPPED!"
exit
fi

#계정아이디 중복확인
USER_ID_count=`cat /etc/passwd | grep -w "$ID" | wc -l`
if [ "$USER_ID_count" -ge "1" ]; then
echo "The User's id is OVERLAPPED!"
exit
fi

#신청자 학번입력
#read -p "신청자 학번을 입력해 주세요 : " USER_NO

#USER_NO_count=`cat /etc/passwd | grep -w "$USER_NO" | wc -l`
#if [ "$USER_NO_count" -ge "1" ]; then
#echo "중복되는 학번이 존재합니다. 기존에 신청했는지 확인하여 주세요."
#exit
#fi

echo -n "
The Type of User   	: Class
The Number of User	: $uid
The Group Of User	: $gid
The id of User		: $ID
The Password of User	: $PASS

Press ENTER if correct, otherwise, Press CRTL+C"

read imsy


echo "Creating Class user"
useradd -u "$uid" -g "$gid" -d "$account_root"/"$ID" "$ID"
echo "$PASS" | passwd --stdin "$ID"

chmod 701 "$account_root"/"$ID"

echo "Adjusting quota"
edquota -p quota -u "$ID"

echo "Complete adding an user"
count=$(($count+1))
uid=$(($uid+1))

sed '1d' addID >> addID2
rm -f addID
mv addID2 addID

sed '1d' addPASS >> addPASS2
rm -f addPASS
mv addPASS2 addPASS

done

