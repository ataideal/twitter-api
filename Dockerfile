FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /twitter-api
WORKDIR /twitter-api
COPY Gemfile /twitter-api/Gemfile
COPY Gemfile.lock /twitter-api/Gemfile.lock
RUN bundle install
COPY . /twitter-api
