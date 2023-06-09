class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.boolean :is_private, default: false

      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
