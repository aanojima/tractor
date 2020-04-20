FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /tractor

COPY Gemfile* /vendor/
WORKDIR /vendor
RUN bundle install

ENV app /app
RUN mkdir $app
WORKDIR $app
ADD . $app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000