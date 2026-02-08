# syntax = docker/dockerfile:1

FROM ruby:3.3.6

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    RAILS_ENV=production

WORKDIR /app

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      ca-certificates \
      curl \
      gnupg \
      postgresql-client \
      build-essential \
      libyaml-dev \
      libvips \
    && rm -rf /var/lib/apt/lists/*

# Node.js & Yarnのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# Gemのインストール
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

# アプリケーションコードのコピー
COPY . .

# yarn install を実行
RUN yarn install --frozen-lockfile

# アセットプリコンパイル
RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
