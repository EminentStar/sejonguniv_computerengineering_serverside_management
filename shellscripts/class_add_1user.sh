#!/bin/bash

echo "Input ID "
read ID

echo "Input professor ID"
read prof_ID

dir=/home/account/class/"$prof_ID"


tail /etc/passwd | grep 5000
echo "Input the uid"
read uid

if [ "$ID" = "" ]; then
	echo "input the ID... exit..."
	exit
fi

USER_COUNT_number=`cat /etc/passwd | grep -w "$uid" | wc -l`
if [ "$USER_COUNT_number" -ge "1" ]; then
	echo "Duplicated UID... exit..."
	exit
fi

USER_ID_count=`cat /etc/passwd | grep -w "$ID" | wc -l`
if [ "$USER_ID_count" -ge "1" ]; then
	echo "Duplicated ID... exit..."
	exit
fi

echo "make a user..."
useradd -u "$uid" -g 5000 -d "$dir"/"$ID" "$ID"
echo "$ID" | passwd --stdin "$ID"

chmod 701 "$dir"/"$ID"
chown "$ID":class "$dir"/"$ID"

# edquota -p quota -u "$ID"

echo "Compelete..."
