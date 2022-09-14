#!/bin/bash

PHASE=$1

if [ -z $PHASE ]; then
    echo "Please select a phase:"
    echo "setup"
    echo "tests"
    echo "teardown"
    exit 1
fi

if [ $PHASE == "setup" ]; then
    ansible-playbook mailcow-start-server.yml --diff
    sleep 10
    ansible-playbook mailcow-setup-server.yml --diff --private-key id_ssh_rsa
fi
if [ $PHASE == "tests" ]; then
    ansible-playbook mailcow-integration-tests.yml --diff --private-key id_ssh_rsa
fi
if [ $PHASE == "teardown" ]; then
    ansible-playbook mailcow-delete-server.yml --diff
fi
