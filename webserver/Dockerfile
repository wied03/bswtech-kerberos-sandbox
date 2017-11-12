FROM ruby:2.4.2

RUN gem install rack \
  && cd /tmp \
  && git clone https://github.com/wied03/rack-auth-krb.git \
  && cd rack-auth-krb \
  && gem build rack-auth-krb.gemspec \
  && gem install ./rack-auth-krb-0.2.1.gem \
  && cd .. \
  && rm -rf rack-auth-krb
COPY config.ru /usr/local/bin

EXPOSE 9292/tcp

CMD ["rackup", "-o", "0.0.0.0", "/usr/local/bin/config.ru"]
