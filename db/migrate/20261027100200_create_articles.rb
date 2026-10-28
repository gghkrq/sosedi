class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :summary
      t.text :body
      t.string :category

      t.timestamps
    end
  end
end
