class CreateListings < ActiveRecord::Migration[8.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :city
      t.integer :rent
      t.integer :rooms
      t.integer :max_people
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
