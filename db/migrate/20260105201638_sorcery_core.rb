class SorceryCore < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :password_digest

    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string

    add_index :users, :email, unique: true

    change_column_null :users, :created_at, false
    change_column_null :users, :updated_at, false
  end
end
