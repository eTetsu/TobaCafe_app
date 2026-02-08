# syntax = docker/dockerfile:1

# ===== ビルドステージ =====
FROM ruby:3.3.6 AS builder

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo

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

# ===== 実行ステージ =====
FROM ruby:3.3.6-slim

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    RAILS_ENV=production

WORKDIR /app

# ランタイムに必要なパッケージのみインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      ca-certificates \
      postgresql-client \
      libvips \
    && rm -rf /var/lib/apt/lists/*

# ユーザー作成
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash

# ビルドステージからファイルをコピー
COPY --from=builder --chown=rails:rails /usr/local/bundle /usr/local/bundle
COPY --from=builder --chown=rails:rails /app /app

USER rails

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
