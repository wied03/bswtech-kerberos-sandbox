FROM quay.io/brady/bswtech-docker-base:1.0.42

RUN yum_check.sh krb5-workstation
COPY resources/run.sh /usr/local/bin

CMD ["/usr/local/bin/run.sh"]
