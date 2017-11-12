#!/bin/sh

set -e

DOCKER_IP=`getent hosts kdc | awk '{ print $1 }'`
echo "Setting up resolution of kerberos.example.com to $DOCKER_IP"
echo "$DOCKER_IP kerberos.example.com" >> /etc/hosts
echo "Forcing web server hostname to not include full Docker domain (throws off kerberos principal name)"
WEB_IP=`getent hosts webserver | awk '{ print $1 }'`
echo "$WEB_IP webserver" >> /etc/hosts
echo "Hosts file is now:"
cat /etc/hosts
echo "Getting a kerberos ticket for brady/admin@EXAMPLE.COM"
echo -e "thePassword" | kinit brady/admin@EXAMPLE.COM
echo "kinit complete"
klist
DEST="http://webserver:9292"
echo "HTTP request via Java to $DEST"
# TODO: https://coderanch.com/t/134541/Setting-JAAS-Configuration-file-programmatically instead of jaas.conf
# useSubjectCredsOnly is needed to use our operating system ticket
JAVA_OPTS="-Dsun.security.krb5.debug=true -Djavax.security.auth.useSubjectCredsOnly=false -Djava.security.auth.login.config=/etc/jaas.conf" /usr/local/bin/client/client_build/bin/client_build $DEST
