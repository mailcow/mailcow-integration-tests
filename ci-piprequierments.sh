#!/bin/bash

# Author: ntimo

# Install requierments
pip3 install hcloud > /dev/null
pip3 install jmespath > /dev/null
pip3 install docker > /dev/null

# Install Ansible
ansible-galaxy collection install community.general > /dev/null
ansible-galaxy collection install hetzner.hcloud > /dev/null
