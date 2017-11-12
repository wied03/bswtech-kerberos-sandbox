FROM quay.io/brady/bswtech-docker-base:1.0.42

RUN yum_check.sh krb5-workstation java-1.8.0-openjdk

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-1.b12.el7_4.x86_64/jre

COPY java /usr/local/bin/client_build

RUN cd /usr/local/bin/client_build \
  && ls -la . \
  && ./gradlew --no-daemon clean build uberjar \
  && cd /usr/local/bin \
  && mkdir client \
  && cd client \
  && tar xvf /usr/local/bin/client_build/build/distributions/client_build.tar \
  && rm -rf /usr/local/bin/client_build

COPY resources/run.sh /usr/local/bin
COPY resources/krb5.conf /etc
COPY resources/jaas.conf /etc

CMD ["/usr/local/bin/run.sh"]
