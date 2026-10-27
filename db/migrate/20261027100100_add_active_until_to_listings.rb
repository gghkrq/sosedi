class AddActiveUntilToListings < ActiveRecord::Migration[8.1]
  def change
    add_column :listings, :active_until, :date
  end
end
