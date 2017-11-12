FROM ruby:2.4.2

RUN gem install rack rack-auth-krb
COPY config.ru /usr/local/bin

EXPOSE 9292/tcp

CMD ["rackup", "-o", "0.0.0.0", "/usr/local/bin/config.ru"]
