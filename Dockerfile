FROM ruby:2.4.1

MAINTAINER Eyal.stoler@kenshoo.com

RUN apt-get update -qq && apt-get install -y build-essential libmysqlclient-dev nodejs
RUN apt-get install -y imagemagick
RUN apt-get update
RUN gem install mysql2

ENV APP_HOME /app

ARG MYSQL_DATABASE='spree'
ARG MYSQL_USER='root'
ARG MYSQL_PASSWORD=''
ARG MYSQL_HOST='127.0.01'
ARG MYSQL_PORT=3306

ENV MYSQL_DATABASE ${MYSQL_DATABASE}
ENV MYSQL_USER ${MYSQL_USER}
ENV MYSQL_PASSWORD ${MYSQL_PASSWORD}
ENV MYSQL_HOST ${MYSQL_HOST}
ENV MYSQL_PORT ${MYSQL_PORT}

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
###If datbase does not exist - uncomment the following line
#RUN rails db:create
###The following line will 
#RUN rails db:migrate
### Create tables and other objects for the application
#RUN rails db:seed AUTO_ACCEPT=1
### This will load sample data (some products, orders, etc) into the database. No need to run for exsiting database
#RUN rails spree_sample:load

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
