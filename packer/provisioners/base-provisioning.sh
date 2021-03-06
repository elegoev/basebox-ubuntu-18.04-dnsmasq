#!/bin/bash

provision_dir="/home/vagrant/files-prov"
application_file_path="/vagrant/installed-application.md"

# install dnsmasq
while :
do
  sudo apt-get install -y dnsmasq
  retcode=$?
  if [ $retcode -eq 0 ]; then
    break
  fi
  echo "sleep 5s ..."
  sleep 5
done
sudo cp $provision_dir/dnsmasq/dnsmasq.conf /etc/dnsmasq.conf

# disable systemd-resolved
resolve_file="/etc/resolv.conf"
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo rm $resolve_file

# create resolve.conf
sudo cp  $provision_dir/dnsmasq/resolv.conf $resolve_file
sudo chattr +i $resolve_file
sudo lsattr $resolve_file

# test syntax resolve.conf
sudo dnsmasq --test

# restart dnsmasq
sudo systemctl restart dnsmasq

# set version
DNSMASQ_VERSION=$(dnsmasq --version | grep "Dnsmasq version" | awk  '{print $3}')
echo "# Installed application   "  > $application_file_path
echo "***                       " >> $application_file_path
echo "> dnsmasq $DNSMASQ_VERSION" >> $application_file_path
