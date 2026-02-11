#!/bin/bash
set -e

# サーバーのPIDファイルが残っている場合は削除
rm -f /app/tmp/pids/server.pid

# データベースの準備
bundle exec rails db:prepare

# メインプロセスを実行
exec "$@"
