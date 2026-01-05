class CreateBoards < ActiveRecord::Migration[7.2]
  def change
    create_table :boards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.string :nearest_station
      t.text :opening_hours
      t.integer :coffe_price
      t.integer :seat_count
      t.integer :smorking_policy

      t.timestamps
    end
  end
end
