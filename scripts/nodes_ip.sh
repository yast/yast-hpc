#!/bin/bash


# create broadcast mask

# function for creating broadcast-mask from subnet-mask
getbcastmask()
{
if [ "$1" -eq "255" ]
then
echo 8
fi

if [ "$1" -eq "254" ]
then
echo 7
fi

if [ "$1" -eq "252" ]
then
echo 6
fi

if [ "$1" -eq "248" ]
then
echo 5
fi

if [ "$1" -eq "240" ]
then
echo 4
fi

if [ "$1" -eq "224" ]
then
echo 3
fi

if [ "$1" -eq "192" ]
then
echo 2
fi

if [ "$1" -eq "128" ]
then
echo 1
fi

if [ "$1" -eq "0" ]
then
echo 0
fi
}


# broadcast local subnet
if [ "$1" == "broadcast" ]
then
	part1=$( getbcastmask $( /sbin/ifconfig |grep Bcast|cut -f4 -d":"|cut -f1 -d"."))
	part2=$( getbcastmask $( /sbin/ifconfig |grep Bcast|cut -f4 -d":"|cut -f2 -d"."))
	part3=$( getbcastmask $( /sbin/ifconfig |grep Bcast|cut -f4 -d":"|cut -f3 -d"."))
	part4=$( getbcastmask $( /sbin/ifconfig |grep Bcast|cut -f4 -d":"|cut -f4 -d"."))

	mask=$[$part1+$part2+$part3+$part4] 

	ip=$(/sbin/ifconfig |grep "Bcast"|cut -f2 -d":"|cut -f1 -d" ")
	nmap -sP -n $ip/$mask|grep "appears to be up"|cut -f2 -d" "
fi

# determine if computer is a cluster-node
if [ "$1" == "clusternode" ]
then 
	grep $2 /var/spool/pbs/server_priv/nodes > /dev/nul
	if [ "$?" == "0" ]
	then echo "yes"
	else echo "no"
	fi
fi

# resolve computer-name from ip-address
if [ "$1" == "name" ]
then 
	nmap -sL $2|grep Host|cut -f2 -d" "

fi

# determine number of cpus
if [ "$1" == "cpus" ]
then 
	pbsnodes -a| fgrep -A2 $2 | grep "np =" |uniq | cut -f8 -d" " 
fi

# determine status of node
if [ "$1" == "status" ]
then 
	pbsnodes -a| fgrep -A2 $2 | grep "state"|uniq|cut -f8 -d" "

fi
