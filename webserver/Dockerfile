FROM ruby:2.4.2

RUN gem install rack \
  && cd /tmp \
  && git clone https://github.com/wied03/rack-auth-krb.git \
  && cd rack-auth-krb \
  && gem build rack-auth-krb.gemspec \
  && gem install ./rack-auth-krb-0.2.1.gem \
  && cd .. \
  && rm -rf rack-auth-krb
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y krb5-user
# For some reason, this directory was missing and we can't pull down our keys without it
RUN mkdir /etc/krb5.conf.d
COPY config.ru /usr/local/bin
COPY run.sh /usr/local/bin
COPY krb5.conf /etc

EXPOSE 9292/tcp

CMD ["/usr/local/bin/run.sh"]
