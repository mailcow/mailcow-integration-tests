#!/bin/bash

# Author: ntimo

# Install requierments
echo "Installing pip requirements"
echo ""
sudo pip3 install hcloud
sudo pip3 install jmespath
sudo pip3 install docker

# Install Ansible
echo ""
echo ""
echo "Installing Ansible Galaxy requirements"
echo ""
ansible-galaxy collection install community.general
ansible-galaxy collection install hetzner.hcloud
