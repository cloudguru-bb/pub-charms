#! /bin/bash
set -e


echo "installing ovs"
sudo apt-get install -y openvswitch-switch

echo "installing wget"
sudo apt-get install -y wget


echo "installing ovs-docker"
cd /usr/bin
sudo wget https://raw.githubusercontent.com/openvswitch/ovs/master/utilities/ovs-docker

echo "changing ovs-docker permissions"
sudo chmod a+rwx ovs-docker

echo "setup ovs bridge = mwc-br1"
sudo ovs-vsctl add-br mwc-br1
sudo ifconfig mwc-br1 10.42.11.1 netmask 255.255.255.0 up

echo "adding port of ems"
sudo ovs-docker add-port mwc-br1 eth0 epic_ems_1 --ipaddress=10.42.11.100/24

echo "adding port of mme"
sudo ovs-docker add-port mwc-br1 eth0 epic_mme_1 --ipaddress=10.42.11.101/24

echo "adding port of hss"
sudo ovs-docker add-port mwc-br1 eth0 epic_hss_1 --ipaddress=10.42.11.102/24

echo "adding port of pcrf"
sudo ovs-docker add-port mwc-br1 eth0 epic_pcrf_1 --ipaddress=10.42.11.106/24

echo "adding port of sgw"
sudo ovs-docker add-port mwc-br1 eth0 epic_sgw_1 --ipaddress=10.42.11.103/24

echo "adding port of pgw"
sudo ovs-docker add-port mwc-br1 eth0 epic_pgw_1 --ipaddress=10.42.11.104/24

echo "adding port of sdn_fabric"
sudo ovs-docker add-port mwc-br1 eth0 epic_fabric_1 --ipaddress=10.42.11.1/24

sudo ovs-vsctl add-port mwc-br1 eth1

echo "ovs install and setup complete"
