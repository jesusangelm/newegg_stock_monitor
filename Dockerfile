FROM ruby:3.0-alpine

LABEL maintainer="angel@marin.cx"

# RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
#nodejs \
#libpq-dev

ENV APP_PATH /var/app/
ENV TMP_PATH /tmp/
ENV RAILS_ENV production
ENV RACK_ENV production
ENV NODE_ENV production
ENV RAILS_PORT 3000
ENV RAILS_SERVE_STATIC_FILES true

RUN apk -U add --no-cache \
build-base \
git \
postgresql-dev \
postgresql-client \
libxml2-dev \
libxslt-dev \
nodejs \
yarn \
imagemagick \
tzdata \
&& rm -rf /var/cache/apk/* \
&& mkdir -p $APP_PATH



COPY Gemfile* $APP_PATH
WORKDIR $APP_PATH
RUN bundle install
RUN gem install foreman

COPY . $APP_PATH

CMD ["foreman", "start"]
