#!/bin/bash



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

#  print all cluster-nodes
if [ "$1" == "clusternodes" ]
then 
	pbsnodes -a|cut -f1 -d" "|uniq -u
fi

# get ip-address from computer-name
if [ "$1" == "ip" ]
then 
	gethostip -d $2

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
