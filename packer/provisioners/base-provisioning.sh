#!/bin/bash

provision_dir="/home/vagrant/provision"

# install dnsmasq
sudo apt-get install -y dnsmasq
sudo cp $provision_dir/files/dnsmasq/dnsmasq.conf /etc/dnsmasq.conf

# disable systemd-resolved
resolve_file="/etc/resolv.conf"
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo rm $resolve_file

# create resolve.conf
sudo cp  $provision_dir/files/dnsmasq/resolv.conf $resolve_file
sudo chattr +i $resolve_file
sudo lsattr $resolve_file

# test syntax resolve.conf
sudo dnsmasq --test

# restart dnsmasq
sudo systemctl restart dnsmasq

# cleanup provisioning files
sudo rm -rf $provision_dir

# set version
DNSMASQ_VERSION=$(dnsmasq --version | grep "Dnsmasq version" | awk  '{print $3}')
# echo "$DNSMASQ_VERSION" > /vagrant/version
