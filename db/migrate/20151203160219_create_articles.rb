class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.text :description
      t.boolean :isNew
      t.boolean :isReview
      t.boolean :onHomePage

      t.timestamps null: false
    end
  end
end
