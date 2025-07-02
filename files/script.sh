#!/bin/bash

# generate key
ssh-keygen -t rsa -b 2048 -N "" -f ~/.ssh/id_rsa

# copy public key to both nodes
sshpass -p "ansible" ssh-copy-id -o StrictHostKeyChecking=no ansible@ubuntu-node
sshpass -p "ansible" ssh-copy-id -o StrictHostKeyChecking=no ansible@centos-node

# now your inventory can reference the key:
ansible all -m ping -i inventory.ini