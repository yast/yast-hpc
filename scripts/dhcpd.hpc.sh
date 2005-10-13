#!/bin/bash

A1=$( /sbin/ifconfig|grep -e "Bcast"|cut -f2 -d":"|cut -f1 -d"."|cut -f1 -d" " )    
A2=$( /sbin/ifconfig|grep -e "Bcast"|cut -f2 -d":"|cut -f2 -d"."|cut -f1 -d" " )    
A3=$( /sbin/ifconfig|grep -e "Bcast"|cut -f2 -d":"|cut -f3 -d"."|cut -f1 -d" " )    
A4=$( /sbin/ifconfig|grep -e "Bcast"|cut -f2 -d":"|cut -f4 -d"."|cut -f1 -d" " )    

M1=$( /sbin/ifconfig|grep -e "Bcast"|cut -f4 -d":"|cut -f1 -d"."|cut -f1 -d" " )    
M2=$( /sbin/ifconfig|grep -e "Bcast"|cut -f4 -d":"|cut -f2 -d"."|cut -f1 -d" " )    
M3=$( /sbin/ifconfig|grep -e "Bcast"|cut -f4 -d":"|cut -f3 -d"."|cut -f1 -d" " )    
M4=$( /sbin/ifconfig|grep -e "Bcast"|cut -f4 -d":"|cut -f4 -d"."|cut -f1 -d" " )

N1=$(( $A1&$M1 ))
N2=$(( $A2&$M2 ))
N3=$(( $A3&$M3 ))
N4=$(( $A4&$M4 ))

network=$N1.$N2.$N3.$N4

echo $network

hostip=$( gethostip -d $HOST )
nisdomain=$( cat /etc/defaultdomain ) 

if [ "$( md5sum /etc/dhcpd.conf|cut -f1 -d" " )" == "08fa78baf27131e8952e90b5ffe3e92b" ]
then
	old /etc/dhcpd.conf
	echo -e "subnet $network netmask 255.255.255.0 {" >> /etc/dhcpd.conf
	echo -e "\tgroup \t { # id=\042HPC\042" >> /etc/dhcpd.conf
	echo -e "\t\toption ntp-servers $hostip; " >> /etc/dhcpd.conf
	echo -e "\t\toption nis-servers $hostip; " >> /etc/dhcpd.conf
	echo -e "\t\toption nis-domain \042$nisdomain\042; " >> /etc/dhcpd.conf
	echo -e "\t}"  >> /etc/dhcpd.conf
	echo -e "}"  >> /etc/dhcpd.conf
else
	echo -e "subnet $network netmask 255.255.255.0 {" >> /etc/dhcpd.conf
	echo -e "\tgroup \t { # id=\042HPC\042" >> /etc/dhcpd.conf
	echo -e "\t\toption ntp-servers $hostip; " >> /etc/dhcpd.conf
	echo -e "\t\toption nis-servers $hostip; " >> /etc/dhcpd.conf
	echo -e "\t\toption nis-domain \042$nisdomain\042; " >> /etc/dhcpd.conf
	echo -e "\t}"  >> /etc/dhcpd.conf
	echo -e "}"  >> /etc/dhcpd.conf
fi
