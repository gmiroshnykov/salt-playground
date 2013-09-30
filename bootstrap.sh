#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y vim python-software-properties python-pip
sudo pip install GitPython

wget -O - http://bootstrap.saltstack.org | sudo sh -s -- -M git develop

sudo service salt-master stop
sudo service salt-minion stop

echo "127.0.0.1 salt" | sudo tee -a /etc/hosts > /dev/null

sudo salt-key --gen-keys=salt-playground.dev
sudo mkdir -p /etc/salt/pki/master/minions
sudo cp salt-playground.dev.pub /etc/salt/pki/master/minions/salt-playground.dev

sudo mkdir -p /etc/salt/pki/minion
sudo mv salt-playground.dev.pem /etc/salt/pki/minion/minion.pem
sudo mv salt-playground.dev.pub /etc/salt/pki/minion/minion.pub

sudo service salt-master start
sudo service salt-minion start
