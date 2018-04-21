FROM ruby:2.4.1

MAINTAINER Eyal.stoler@kenshoo.com

RUN apt-get update -qq && apt-get install -y build-essential libmysqlclient-dev nodejs
RUN apt-get install -y imagemagick
RUN apt-get update

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

RUN rails db:migrate
RUN rails db:seed AUTO_ACCEPT=1
RUN rails spree_sample:load

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
