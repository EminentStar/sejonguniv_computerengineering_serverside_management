#!/bin/sh

echo "extract dir names to file"
echo "{usage | arg1=output filename, arg2=target directory}"
echo "{exmaple : sh extract_dirnames.sh DIRS /home/account/class/tspark }"

outputfile=$1
targetdir=$2

echo "output filename  : $outputfile"
echo "target directory : $targetdir"

if [ ! -d $targetdir ]
then
	echo "$targetdir is not exist"
	exit
fi

if [ -f $outputfile ]
then
	echo "$outputfile is already exist"
	exit
fi

curr_dir=`pwd`
outputfile=$curr_dir'/'$outputfile
cd $targetdir

for dir in `ls -d *`; do
	#echo $dir;
	echo $dir >> $outputfile;
done
