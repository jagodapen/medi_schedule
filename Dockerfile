FROM ruby:3.2.2

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    postgresql-client \
    yarn \
    git \
    tzdata \
    && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . .

RUN gem install bundler
RUN bundle install
RUN yarn install --check-files

EXPOSE 3000
