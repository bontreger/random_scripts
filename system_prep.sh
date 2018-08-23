#!/bin/bash


# Remove entries in /etc/systemctl/network-scripts/ifcfg-eth0
echo $'onboot=yes\ndevice=eth0' > /etc/sysconfig/network-scripts/ifcfg-eth0

#Remove contents from /etc/machine-id
chmod 777 /etc/machine-id
echo "" > /etc/machine-id
chmod 444 /etc/machine-id

#Remove persistent-net.rules
rm -rf /etc/udev/rules.d/70-persistent-net.rules

#Unregister from RHN/RHSM
subscription-manager unsubscribe --all
subscription-manager unregister
subscription-manager clean

#Clean out ssh configs
rm -rf /etc/ssh/ssh_host_*

#Install cloud-init and initial-setup
yum -y install cloud-init initial-setup

#enable cloud-init and initial-setup
systemctl enable cloud-init
systemctl enable initial-setup

echo "Prep complete, please run `shutdown -h now`"
