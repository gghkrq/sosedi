class AddMoreFieldsToPreferences < ActiveRecord::Migration[8.1]
  def change
    add_column :preferences, :guests, :string
    add_column :preferences, :noise, :string
    add_column :preferences, :alcohol, :string
    add_column :preferences, :remote_work, :boolean, default: false, null: false
    add_column :preferences, :shared_food, :boolean, default: false, null: false
  end
end
