#!/bin/sh

DOCKER_IP=`getent hosts server | awk '{ print $1 }'`
echo "Setting up resolution of kerberos.example.com to $DOCKER_IP"
echo "$DOCKER_IP" >> /etc/hosts
bash -l
#ktadd -k /etc/krb5.keytab host/blah.example.com
