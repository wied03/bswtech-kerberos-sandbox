#!/bin/bash

echo -e "thePassword\nthePassword" | kadmin.local -q "addprinc brady/admin"
kadmin.local -q "addprinc -randkey host/blah.example.com"
/usr/sbin/krb5kdc
/usr/sbin/_kadmind -nofork
