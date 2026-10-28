class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.text :text
      t.boolean :read, default: false, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
