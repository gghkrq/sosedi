class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :age, :integer
    add_column :users, :about, :text
    add_column :users, :occupation, :string
    add_column :users, :budget, :integer
    add_column :users, :city, :string
    add_column :users, :rating, :decimal, precision: 2, scale: 1, default: 0
  end
end
