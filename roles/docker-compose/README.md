| Branch  | Linting Status |
|:-------:|:------------:|
|Master   | [![Build Status](https://drone.nowitzki.network/api/badges/Ansible-Roles/docker-compose/status.svg)](https://drone.nowitzki.network/Ansible-Roles/docker-compose)   |

# docker_compose

Ansible role to install [docker-compose](https://docs.docker.com/compose).

## Requirements

| Ansible Role   | Description                     |
|----------------|---------------------------------|
| docker         | Installs Docker                 |

## Role Variables

name | purpose | possible values
---|---|---
`docker_compose_version` | selects the docker-compose version | `1.24.1`

## Dependencies

None.

## Example Playbook
```yaml
---

    - name: Install Python
      hosts: servers
      gather_facts: false
      become: true
      roles:
         - { role: raw,0.0, vars: {command: 'apt-get install -y python'} }

    - name: Main Playbook
      hosts: servers
      gather_facts: true
      roles:
         - Ansible-Roles.docker-ce
         - Absible-Roles.docker-compose
         - ...
```