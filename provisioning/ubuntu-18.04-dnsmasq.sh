#!/bin/bash

# set color
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}##################################${NC}"
echo -e "${BLUE}# >>>> start provisioning         ${NC}"
echo -e "${BLUE}##################################${NC}"

# install dnsmasq
echo -e "${GREEN}#################################${NC}"
echo -e "${GREEN}# >>>> install dnsmasq           ${NC}"
echo -e "${GREEN}#################################${NC}"
sudo apt-get install -y dnsmasq
sudo cp /vagrant/files/dnsmasq/dnsmasq.conf /etc/dnsmasq.conf

# disable systemd-resolved
echo -e "${GREEN}#################################${NC}"
echo -e "${GREEN}# >>>> disable systemd-resolved  ${NC}"
echo -e "${GREEN}#################################${NC}"
RESOLVFILE="/etc/resolv.conf"
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo rm $RESOLVFILE

# create resolve.conf
echo -e "${GREEN}#################################${NC}"
echo -e "${GREEN}# >>>> create resolve.conf       ${NC}"
echo -e "${GREEN}#################################${NC}"
sudo cp  /vagrant/files/dnsmasq/resolv.conf $RESOLVFILE
sudo chattr +i $RESOLVFILE
sudo lsattr $RESOLVFILE

# test syntax resolve.conf
echo -e "${GREEN}#################################${NC}"
echo -e "${GREEN}# >>>> test resolve.conf ${NC}"
echo -e "${GREEN}#################################${NC}"
sudo dnsmasq --test

# restart dnsmasq
echo -e "${GREEN}#################################${NC}"
echo -e "${GREEN}# >>>> restart dnsmasq ${NC}"
echo -e "${GREEN}#################################${NC}"
sudo systemctl restart dnsmasq

# get timestamp
echo -e "${GREEN}#################################${NC}"
echo -e "${GREEN}# >>>> restart dnsmasq ${NC}"
echo -e "${GREEN}#################################${NC}"
DATE=`date +%Y%m%d%H%M`

# set version
DNSMASQ_VERSION=$(dnsmasq --version | awk  '{print $3}')
echo "$DNSMASQ_VERSION" > /vagrant/version

echo -e "${BLUE}#################################${NC}"
echo -e "${BLUE}# >>>> end provisioning          ${NC}"
echo -e "${BLUE}#################################${NC}"
