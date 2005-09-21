#!/bin/bash

mountpoint=$( grep SHAREPOINT /etc/sysconfig/hpc.cfg |cut -f2 -d":" );
homedirs=$( grep HOMEPOINT /etc/sysconfig/hpc.cfg |cut -f2 -d":" );


# create a node-install script at HPCSHARE-Directory

echo "#!/bin/bash" > $mountpoint/install.sh
echo "# DO NOT EDIT THIS FILE !" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "# install needed rpms on client" >> $mountpoint/install.sh
echo "/sbin/yast -i OpenPBS OpenPBS-mom" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "# enable hostbased ssh authentication" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "sed '/HostbasedAuthentication/d' /etc/ssh/ssh_config > /tmp/ssh.tmp" >> $mountpoint/install.sh
echo "echo \"HostbasedAuthentication yes\" >> /tmp/ssh.tmp" >> $mountpoint/install.sh
echo "mv /tmp/ssh.tmp /etc/ssh/ssh_config" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "sed '/EnableSSHKeysign/d' /etc/ssh/ssh_config > /tmp/ssh.tmp" >> $mountpoint/install.sh
echo "echo \"EnableSSHKeysign yes\" >> /tmp/ssh.tmp" >> $mountpoint/install.sh
echo "mv /tmp/ssh.tmp /etc/ssh/ssh_config" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "sed '/HostbasedAuthentication/d' /etc/ssh/sshd_config > /tmp/sshd.tmp" >> $mountpoint/install.sh
echo "echo \"HostbasedAuthentication yes\" >> /tmp/sshd.tmp" >> $mountpoint/install.sh
echo "mv /tmp/sshd.tmp /etc/ssh/sshd_config" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "sed '/PasswordAuthentication/d' /etc/ssh/sshd_config > /tmp/sshd.tmp" >> $mountpoint/install.sh
echo "echo \"PasswordAuthentication yes\" >> /tmp/sshd.tmp" >> $mountpoint/install.sh
echo "mv /tmp/sshd.tmp /etc/ssh/sshd_config" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "rcsshd reload" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "mountpoint=\$( ypcat auto.hpc |cut -f2 -d':' )" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "if ! test -h /etc/ssh/shosts.equiv; then" >> $mountpoint/install.sh
echo "        ln -s /hpc$mountpoint/shosts.equiv /etc/ssh/shosts.equiv" >> $mountpoint/install.sh
echo "fi" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "if ! test -h /etc/ssh/ssh_known_hosts; then" >> $mountpoint/install.sh
echo "        ln -s /hpc$mountpoint/ssh_known_hosts /etc/ssh/ssh_known_hosts" >> $mountpoint/install.sh
echo "fi" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "chmod u+s /usr/lib/ssh/ssh-keysign" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "" >> $mountpoint/install.sh
echo "# set default server entry" >> $mountpoint/install.sh
echo "echo \"$HOSTNAME\" > /var/spool/pbs/default_server" >> $mountpoint/install.sh

echo "# set mom-configuration" >> $mountpoint/install.sh
echo "echo \"\\\$logevent 0x1f\" > /var/spool/pbs/mom_priv/config" >> $mountpoint/install.sh
echo "echo \"\\\$clienthost $HOSTNAME\" >> /var/spool/pbs/mom_priv/config" >> $mountpoint/install.sh
echo "echo \"\\\$usecp $HOSTNAME:$homedirs $homedirs\" >> /var/spool/pbs/mom_priv/config" >> $mountpoint/install.sh
echo "echo \"\\\$prologalarm 110\" >> /var/spool/pbs/mom_priv/config" >> $mountpoint/install.sh

echo "rcpbs_mom start" >> $mountpoint/install.sh
chmod u+x $mountpoint/install.sh
