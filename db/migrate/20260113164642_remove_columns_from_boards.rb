class RemoveColumnsFromBoards < ActiveRecord::Migration[7.2]
  def change
    # enum関連のカラムを削除
    remove_column :boards, :walking_time, :integer, null: false, default: 0
    remove_column :boards, :seat_capacity, :integer, null: false, default: 0
    remove_column :boards, :floor_level, :integer, null: false, default: 0

    # その他のカラムを削除
    remove_column :boards, :small_coffee_price, :integer, null: false
    remove_column :boards, :website_url, :string
  end
end
