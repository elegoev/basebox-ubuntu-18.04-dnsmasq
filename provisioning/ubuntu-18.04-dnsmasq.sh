#!/bin/bash

# define shared folders
SHAREDFOLDERDIR="/mnt/sharedfolder"

# update ubuntu
sudo apt -y update

# install nfs kernel
sudo apt install -y nfs-kernel-server
sudo apt install -y lsb-core

# create shared folder
sudo mkdir -p $SHAREDFOLDERDIR
sudo chown nobody:nogroup $SHAREDFOLDERDIR
sudo chmod 777 $SHAREDFOLDERDIR

# add shared folder to exports
echo "# $SHAREDFOLDERDIR  172.16.1.0/255.255.255.0(rw,async)" >> /etc/exports

# create date string
DATE=`date +%Y%m%d%H%M`

# set version
UBUNTU_VERSION=$(lsb_release -a | grep Release | awk  '{print $2}')
echo "ubuntu-$UBUNTU_VERSION" > /vagrant/version
