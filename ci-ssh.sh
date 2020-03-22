#!/bin/bash

# Author: ntimo

SSHKEYFILE=/drone/src/id_ssh_rsa
if [ -f "$SSHKEYFILE" ]; then
  chmod 0600 $SSHKEYFILE
fi
