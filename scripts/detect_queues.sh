#!/bin/bash


#----------------------------------------------------
# Detect installation of pbs/bin & copy config to /tmp
#----------------------------------------------------
if [ "$1" == "init" ]
then
	if ( test -d /opt/pbs/bin/ )
	then
		if ( ! test -d /tmp/YaST2-HPC )
		then
			mkdir /tmp/YaST2-HPC
		fi
        	/opt/pbs/bin/qmgr -c "print server" > /tmp/YaST2-HPC/queue.conf
	fi
fi


#----------------------------------------------------
# Read Queue configuration data from qmgr
#----------------------------------------------------
if [ "$1" == "config" ]
then
	grep "create queue" /tmp/YaST2-HPC/queue.conf|cut -f3 -d" "
fi


#----------------------------------------------------
# Queue Values
#----------------------------------------------------
# usage: detect_queues.sh value parallel 
if [ "$1" == "queue" ]
then
		grep "set queue $2" /tmp/YaST2-HPC/queue.conf|cut -f4-6 -d" "
fi

