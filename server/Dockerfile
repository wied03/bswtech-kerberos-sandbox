FROM quay.io/brady/bswtech-docker-base:1.0.42

RUN yum_check.sh krb5-server
COPY resources/krb5.conf /etc
RUN echo -e "thekey\nthekey" | /usr/sbin/kdb5_util create -s

