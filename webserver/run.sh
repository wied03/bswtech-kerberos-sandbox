#!/bin/bash

set -e

DOCKER_IP=`getent hosts kdc | awk '{ print $1 }'`
echo "Setting up resolution of kerberos.example.com to $DOCKER_IP"
echo "$DOCKER_IP kerberos.example.com" >> /etc/hosts
echo "Pulling down keys from KDC into webserver keytab..."
KEYTAB_LOCATION="/etc/krb5.keytab"
HOSTNAME_TO_USE="webserver"
echo "Adjusting hostname to match principal ($HOSTNAME_TO_USE)"
hostname $HOSTNAME_TO_USE
echo -e "thePassword" | kadmin -p brady/admin@EXAMPLE.COM -q "ktadd -k $KEYTAB_LOCATION HTTP/$HOSTNAME_TO_USE@EXAMPLE.COM"
echo "Done pulling down keys from KDC into webserver keytab, launching web server..."
KEYTAB_LOCATION=$KEYTAB_LOCATION rackup -o 0.0.0.0 /usr/local/bin/config.ru
