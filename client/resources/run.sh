#!/bin/sh

DOCKER_IP=`getent hosts kdc | awk '{ print $1 }'`
echo "Setting up resolution of kerberos.example.com to $DOCKER_IP"
echo "$DOCKER_IP kerberos.example.com" >> /etc/hosts
echo "Getting a kerberos ticket for brady/admin@EXAMPLE.COM"
echo -e "thePassword" | kinit brady/admin@EXAMPLE.COM
echo "kinit complete"
klist
DEST="http://webserver:9292"
echo "HTTP request via Java to $DEST"
JAVA_OPTS="-Dsun.security.krb5.debug=true -Djavax.security.auth.useSubjectCredsOnly=false -Djava.security.auth.login.config=/etc/jaas.conf" /usr/local/bin/java/bin/java $DEST
