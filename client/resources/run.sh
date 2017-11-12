#!/bin/sh

DOCKER_IP=`getent hosts kdc | awk '{ print $1 }'`
echo "Setting up resolution of kerberos.example.com to $DOCKER_IP"
echo "$DOCKER_IP kerberos.example.com" >> /etc/hosts
echo -e "thePassword" | kinit brady/admin@EXAMPLE.COM
klist
