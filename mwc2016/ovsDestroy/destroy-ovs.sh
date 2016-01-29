#! /bin/bash
set -e

echo "deleting port of ems"
sudo ovs-docker del-port mwc-br1 eth0 epic_ems_1 --ipdelress=10.42.11.100/24

echo "deleting port of mme"
sudo ovs-docker del-port mwc-br1 eth0 epic_mme_1 --ipdelress=10.42.11.101/24

echo "deleting port of hss"
sudo ovs-docker del-port mwc-br1 eth0 epic_hss_1 --ipdelress=10.42.11.102/24

echo "deleting port of pcrf"
sudo ovs-docker del-port mwc-br1 eth0 epic_pcrf_1 --ipdelress=10.42.11.106/24

echo "deleting port of sgw"
sudo ovs-docker del-port mwc-br1 eth0 epic_sgw_1 --ipdelress=10.42.11.103/24

echo "deleting port of pgw"
sudo ovs-docker del-port mwc-br1 eth0 epic_pgw_1 --ipdelress=10.42.11.104/24

echo "deleting port of sdn_fabric"
sudo ovs-docker del-port mwc-br1 eth0 epic_fabric_1 --ipdelress=10.42.11.1/24
sudo ovs-vsctl del-port mwc-br1 eth1
sudo ovs-vsctl del-br mwc-br1

sudo rm /usr/bin/ovs-docker

sudo apt-get remove -y wget

sudo apt-get remove -y openvswitch-switch
