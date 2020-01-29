# mailcow-integration-test-suite

Latest test result from mailcow: [![Build Status](https://drone.mailcow.email/api/badges/mailcow/mailcow-dockerized/status.svg)](https://drone.mailcow.email/mailcow/mailcow-dockerized)  
HTML reports: [https://int-test.mailcow.email/results/](https://int-test.mailcow.email/results/)

## About this project

This project provides the tests that are run everytime a new commit is added to the mailcow master branch.  
Tests are run on Hetzner Cloud servers using Drone CI.

## Project structure

The project is structured like a normal ansible-playbook, it contains roles which contain all the logic.  
The most important is the mailcow-tests role since it contains all the test logic.

|       Role       |                      Description                      |
| :--------------: | :---------------------------------------------------: |
|   apt-updates    | Installs apt-updates and reboots the server if needed |
|    cloud-init    |            Waits for cloud init to finish             |
|  cloudflare-dns  |  Created the needed dns records for the test mailcow  |
|    docker-ce     |                    Installs docker                    |
|  docker-compose  |                Installs docker-compose                |
|     mailcow      | Sets up mailcow and buids the containers from source  |
|     netplan      |        Fixes the Hetzner Cloud network config         |
| npm-requierments |             Installs needed npm packages              |
| pip-requierments |             Installs needed pip packages              |


Shell Scripts used by the project:

|     .sh file     |                  Description                   |
| :--------------: | :--------------------------------------------: |
|      ci.sh       | Used to create on demand variables for ansible |
| namegenerator.sh |             Generates random names             |

## How to contribute

If you want to contribute feel free to do so. PRs are always welcome and will be reviewed as soon as possible.

### Variable naming

Variables are prefixed by the component they belong to for example all mailcow variables start with mailcow__ please note the use of two underscores to make clear its a prefix. Secrets are prefixed with vault__mailcow__ to make sure they are secrets from the vault.
