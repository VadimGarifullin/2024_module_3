#!/bin/bash

WEB1_IP=$(cat /home/altlinux/WEB1.ip)
WEB2_IP=$(cat /home/altlinux/WEB2.ip)
echo $WEB1_IP
echo $WEB2_IP

cat <<CONF > /home/altlinux/hosts
---
all:
    children:
            WEB:
                hosts:
                    WEB1:
                        ansible_host: $WEB1_IP
                        ansible_ssh_user: altlinux
                        ansible_ssh_private_key_file: /home/altlinux/ControlVM-RTyBHnZ0.pem
                    WEB2:
                        ansible_host: $WEB2_IP
                        ansible_ssh_user: altlinux
                        ansible_ssh_private_key_file: /home/altlinux/ControlVM-RTyBHnZ0.pem
CONF