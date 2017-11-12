#!/bin/bash

set -e

echo -e "thePassword\nthePassword" | kadmin.local -q "addprinc brady/admin"
# We need a principal, "aka SPN" for our web server
kadmin.local -q "addprinc -randkey HTTP/webserver@EXAMPLE.COM"

/usr/sbin/krb5kdc
/usr/sbin/_kadmind -nofork
