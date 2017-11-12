FROM quay.io/brady/bswtech-docker-base:1.0.42

RUN yum_check.sh krb5-workstation java-1.8.0-openjdk
COPY resources/run.sh /usr/local/bin
COPY resources/krb5.conf /etc
COPY java/build/distributions/java.tar /usr/local/bin
RUN cd /usr/local/bin \
  && tar xvf java.tar
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-1.b12.el7_4.x86_64/jre

CMD ["/usr/local/bin/run.sh"]
