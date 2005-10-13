#!/bin/bash

## define some system variables
IP=$( gethostip -d $HOSTNAME )
SHAREPOINT=$( grep SHAREPOINT /etc/sysconfig/hpc.cfg|cut -f2 -d":" )
ALLNAMES_KH=$( grep $HOSTNAME /etc/hosts| tr -s -t " " ","  )
ALLNAMES_EQ=$( grep $HOSTNAME /etc/hosts| tr -s -t " " "\n"  )

## Check if root-rsa-key is present; if not -> create one

if ! test -f /root/.ssh/id_rsa ; then
	ssh-keygen -t rsa -f /root/.ssh/id_rsa -N '' -q
fi

## Add server ssh-keys for hostbased auth
if ! grep $HOSTNAME $SHAREPOINT/ssh_known_hosts ; then
ssh-keyscan -t rsa,dsa $ALLNAMES_KH >> $SHAREPOINT/ssh_known_hosts
fi

## Add server ssh-keys for hostbased auth
if ! grep $HOSTNAME $SHAREPOINT/shosts.equiv ; then
echo "$ALLNAMES_EQ" >> $SHAREPOINT/shosts.equiv
fi

## switch ssh authentication to hostbased
sed '/HostbasedAuthentication/d' /etc/ssh/ssh_config > /tmp/ssh.tmp
echo "HostbasedAuthentication yes" >> /tmp/ssh.tmp
mv /tmp/ssh.tmp /etc/ssh/ssh_config

sed '/EnableSSHKeysign/d' /etc/ssh/ssh_config > /tmp/ssh.tmp
echo "EnableSSHKeysign yes" >> /tmp/ssh.tmp
mv /tmp/ssh.tmp /etc/ssh/ssh_config

sed '/HostbasedAuthentication/d' /etc/ssh/sshd_config > /tmp/sshd.tmp
echo "HostbasedAuthentication yes" >> /tmp/sshd.tmp
mv /tmp/sshd.tmp /etc/ssh/sshd_config

sed '/PasswordAuthentication/d' /etc/ssh/sshd_config > /tmp/sshd.tmp
echo "PasswordAuthentication yes" >> /tmp/sshd.tmp
mv /tmp/sshd.tmp /etc/ssh/sshd_config

rcsshd reload


if ! test -h /etc/ssh/shosts.equiv; then
        ln -s $SHAREPOINT/shosts.equiv /etc/ssh/shosts.equiv
fi

if ! test -h /etc/ssh/ssh_known_hosts; then
        ln -s $SHAREPOINT/ssh_known_hosts /etc/ssh/ssh_known_hosts
fi

chmod u+s /usr/lib/ssh/ssh-keysign

