class CreateBoards < ActiveRecord::Migration[7.2]
  def change
    create_table :boards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :address, null: false
      t.string :nearest_station, null: false
      t.integer :walking_time, null: false
      t.text :opening_hours
      t.integer :small_coffee_price, null: false
      t.integer :seat_capacity, null: false
      t.integer :floor_level, null: false
      t.integer :smoking_policy, null: false
      t.string :website_url

      t.timestamps
    end

    add_index :boards, :nearest_station
  end
end
