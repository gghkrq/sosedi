class AddAuthFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :admin, :boolean, default: false, null: false
    add_index :users, :email, unique: true
  end
end
