class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true
      t.integer :workability_rating, null: false
      t.text :comment

      t.timestamps
    end
    add_index :reviews, [ :user_id, :board_id ], unique: true
  end
end
