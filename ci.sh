#!/bin/bash

# Author: ntimo

# Set permissions
chmod +x ./namegenerator.sh
chmod -R 0744 /drone/src/*
SSHKEYFILE=/drone/src/id_ssh_rsa
if [ -f "$SSHKEYFILE" ]; then
  chmod 0600 $SSHKEYFILE
fi

if [ -z "$VAULT_PW" ]; then
  echo "VAULT_PW is not set"
  exit 1
else
  echo "$VAULT_PW" > /drone/src/.vault-pw
fi

# Set global ansible variables
echo "hcloud_server_name: cowintg${DRONE_COMMIT:0:10}" > /drone/src/group_vars/all/drone_servername.yml
echo "drone_commit_hash: ${DRONE_COMMIT:0:10}" > /drone/src/group_vars/all/drone_commit_hash.yml
echo "drone_commit_hash_long: ${DRONE_COMMIT}" > /drone/src/group_vars/all/drone_commit_hash_long.yml
echo "mailcow__mailbox_user_one: $(./namegenerator.sh)" > /drone/src/group_vars/all/drone_mailcow__mailbox_user_one.yml
echo "mailcow__mailbox_user_two: $(./namegenerator.sh)" > /drone/src/group_vars/all/drone_mailcow_mailcow__mailbox_user_two.yml
echo "mailcow__mailbox_user_alias: $(./namegenerator.sh)" > /drone/src/group_vars/all/drone_mailcow__mailbox_user_alias.yml
echo "mailcow__api_key: $(openssl rand -hex 25)"  > /drone/src/group_vars/all/drone_mailcow__api_key.yml
echo "mailcow__api_key_read_only: $(openssl rand -hex 25)"  > /drone/src/group_vars/all/drone_mailcow__api_key_read_only.yml

domains[0]="010111010.xyz"
domains[0]="4884884.xyz"
domains[0]="8448448.xyz"
domains_size=${#domains[@]}
domains_index=$(($RANDOM % $domains_size))

# set env specific ansible variables
echo "mailcow__dns_zone: ${domains[$domains_index]}" > /drone/src/group_vars/all/drone_mailcow__demo_domain.yml
echo "mailcow__git_repo: ${DRONE_GIT_HTTP_URL}" > /drone/src/group_vars/all/drone_mailcow__git_repo.yml
echo "mailcow__git_http_url: ${DRONE_GIT_HTTP_URL:: -4}" > /drone/src/group_vars/all/drone_mailcow__git_http_url.yml
echo "mailcow__git_version: ${DRONE_COMMIT}" > /drone/src/group_vars/all/drone_mailcow__git_version.yml
