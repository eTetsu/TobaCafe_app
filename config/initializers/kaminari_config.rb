# frozen_string_literal: true

Kaminari.configure do |config|
  # 1ページあたりのデフォルト表示件数
  config.default_per_page = 10

  # 1ページあたりの最大表示件数の上限（nilで無制限）
  # config.max_per_page = nil

  # 現在のページ番号の前後に表示するページ数
  # 例: window = 4なら、現在3ページ目の場合「1 2 [3] 4 5 6 7」
  # config.window = 4

  # 最初と最後に表示するページ数
  # 例: outer_window = 2なら「1 2 ... 5 6 [7] 8 9 ... 98 99」
  # config.outer_window = 0

  # 現在のページより左側に表示するページ数
  # config.left = 0

  # 現在のページより右側に表示するページ数
  # config.right = 0

  # ページネーションに使用するメソッド名（デフォルトは :page）
  # config.page_method_name = :page

  # URLパラメータのキー名（デフォルトは :page → ?page=2）
  # config.param_name = :page

  # ページネーションの最大ページ数（nilで無制限）
  # config.max_pages = nil

  # 1ページ目のURLにパラメータを含めるか（falseなら /boards、trueなら /boards?page=1）
  # config.params_on_first_page = false
end
