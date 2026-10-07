class CreateApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :applications do |t|
      t.text :message
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
