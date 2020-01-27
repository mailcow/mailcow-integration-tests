| Branch  | Linting Status |
|:-------:|:------------:|
|Master   | [![Build Status](https://drone.nowitzki.network/api/badges/Ansible-Roles/docker-ce/status.svg)](https://drone.nowitzki.network/Ansible-Roles/docker-ce)   |
|Dev      | [![Build Status](https://drone.nowitzki.network/api/badges/Ansible-Roles/docker-ce/status.svg?branch=dev)](https://drone.nowitzki.network/Ansible-Roles/docker-ce)  |

# docker-ce

Ansible role to install [Docker](https://www.docker.com) Community Edition.

## Requirements

None.

## Role Variables

None

## Dependencies

None.

## Example Playbook
```yaml
---

    - name: Install Python
      hosts: servers
      become: true
      gather_facts: false
      roles:
         - { role: raw,0.0, vars: {command: 'apt-get install -y python'} }

    - name: Main Playbook
      hosts: servers
      gather_facts: true
      roles:
         - Ansible-Roles.docker-ce
         - ...
```