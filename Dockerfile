FROM ruby:2.7.0

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential postgresql-client nodejs yarn

COPY Gemfile* /vendor/
WORKDIR /vendor
RUN bundle install

ENV app /app
RUN mkdir $app
WORKDIR $app
ADD . $app

RUN yarn install --check-files

CMD [ "run/docker_start.sh" ]