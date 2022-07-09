#!/bin/bash

# Author: ntimo

echo ""
echo "Writing vault password"
if [ -z "$VAULT_PW" ]; then
  echo "VAULT_PW is not set"
  exit 1
else
  echo "$VAULT_PW" > ./.vault-pw
fi

echo ""
echo "Writing vault file"
if [ -z "$VAULT_FILE" ]; then
  echo "VAULT_FILE is not set"
  exit 1
else
  echo $VAULT_FILE | sed 's/ /\n/g' | base64 --decode > ./group_vars/all/secrets.yml
fi

echo ""
echo "Generating CI/CD vars"
# Set global ansible variables
echo "ci_hcloud_server_name: cowintg${GITHUB_SHA:0:10}" > ./group_vars/all/drone_servername.yml
echo "ci_drone_commit_hash: ${GITHUB_SHA:0:10}" > ./group_vars/all/drone_commit_hash.yml
echo "ci_drone_commit_hash_long: ${GITHUB_SHA}" > ./group_vars/all/drone_commit_hash_long.yml
echo "ci_mailcow__mailbox_user_one: $(./namegenerator.sh)" > ./group_vars/all/drone_mailcow__mailbox_user_one.yml
echo "ci_mailcow__mailbox_user_two: $(./namegenerator.sh)" > ./group_vars/all/drone_mailcow_mailcow__mailbox_user_two.yml
echo "ci_mailcow__mailbox_user_alias: $(./namegenerator.sh)" > ./group_vars/all/drone_mailcow__mailbox_user_alias.yml
echo "ci_mailcow__api_key: $(openssl rand -hex 25)"  > ./group_vars/all/drone_mailcow__api_key.yml
echo "ci_mailcow__api_key_read_only: $(openssl rand -hex 25)"  > ./group_vars/all/drone_mailcow__api_key_read_only.yml
echo "ci_mailcow__upload_results: true" > ./group_vars/all/mailcow__upload_results.yml

domains[0]="4884884.xyz"
domains[0]="8448448.xyz"
domains_size=${#domains[@]}
domains_index=$(($RANDOM % $domains_size))

# set env specific ansible variables
echo "ci_mailcow__dns_zone: ${domains[$domains_index]}" > ./group_vars/all/drone_mailcow__demo_domain.yml
echo "ci_mailcow__git_repo: https://github.com/${GITHUB_REPOSITORY}.git" > ./group_vars/all/drone_mailcow__git_repo.yml
echo "ci_mailcow__git_http_url: https://github.com/${GITHUB_REPOSITORY}" > ./group_vars/all/drone_mailcow__git_http_url.yml
echo "ci_mailcow__git_version: ${GITHUB_SHA}" > ./group_vars/all/drone_mailcow__git_version.yml
