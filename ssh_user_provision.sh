#!/bin/bash
#
#
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Cloud init script for Digital Ocean (potentially AWS?)
# Created for Ubuntu 16.04LTS (does it work with 18.xxlts?)
# Functions:
# 	1) creates new sudo user named "alex"
#	2) grants permissions
#	3) copies over existing ssh deps so passwordless login still works
#
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

# user to be created
nixusr="alex"

## create user
echo "adding user '$nixusr'"
sudo adduser $nixusr

echo "making '$nixusr' sudoer"
sudo usermod -aG sudo $nixusr

## nav to nixusr home folder and copy the authorized keys from root
echo "cloning ssh keys from root (setup by cloud provider autoconf)"
cd /home/$nixusr/
if [ ! -d ".ssh" ]; then
  mkdir .ssh
fi
echo $(pwd)
chmod 777 .ssh
cat /root/.ssh/authorized_keys > .ssh/authorized_keys
chown -R $nixusr:$nixusr .ssh
chmod 600 .ssh/authorized_keys
chmod 700 .ssh

# use sed to remove ability to login with passwd
sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
echo 'reconfigured sshd_config'

# restart ssh service to apply changes
service ssh restart
echo 'restarted ssh'
echo "You can now login with the user: $nixusr"

