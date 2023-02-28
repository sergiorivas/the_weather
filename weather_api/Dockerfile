
FROM ruby:3.2.0-slim AS builder

RUN apt-get update \
  && apt-get install -y --no-install-recommends git build-essential curl libpq-dev \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean

COPY Gemfile* .

RUN bundle install

FROM ruby:3.2.0-slim

ENV APP_PATH /app/

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

RUN apt-get update \
  && apt-get install -y git libpq-dev bash ffmpeg \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . .

EXPOSE 3000

ENV RUBYOPT -W0

HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
