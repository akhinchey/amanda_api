FROM ruby:2.3.1-alpine
MAINTAINER Amanda Hinchey <ahinchey@contently.com>

ENV DATABASE_USERNAME=contently
ENV DATABASE_PASSWORD=contently

WORKDIR /code

RUN apk update && apk upgrade
RUN apk add ruby-dev build-base libxml2-dev libxslt-dev libffi-dev postgresql-dev

RUN gem install bundler

ADD Gemfile Gemfile.lock /code/
RUN bundle install

ADD public /code/public
ADD config /code/config

ADD bin /code/bin
ADD lib /code/lib
ADD app /code/app
ADD db /code/db
ADD Rakefile config.ru /code/

RUN apk add libcurl tzdata

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]