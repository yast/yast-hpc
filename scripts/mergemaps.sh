#!/bin/bash
#################################################################
#
# Create NIS-Maps for /etc/auto.home
#
# HOME-Directories will be exported
#
#################################################################

# create mountpoints for HOME-Dirs in /etc/auto.home

for n in $( ls -A $1 )
do
	export=( "$n\t-fstype=nfs\t\t$HOST:/home/$n" ) 
	exdir=$( echo -e $export|cut -f1 -d" ")
	if [ "$n" == "$( grep -w $n /etc/auto.home|cut -f1 )" ] 	
	then
	 	echo "$n already exported"
	else
		echo -e $export >> /etc/auto.home
	fi
done


