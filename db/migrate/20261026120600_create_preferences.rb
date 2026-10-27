class CreatePreferences < ActiveRecord::Migration[8.1]
  def change
    create_table :preferences do |t|
      t.integer :budget
      t.boolean :smoking, default: false, null: false
      t.boolean :pets, default: false, null: false
      t.string :cleanliness
      t.string :schedule
      t.references :user, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
