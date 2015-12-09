class CreateArticleProducts < ActiveRecord::Migration
  def change
    create_table :article_products do |t|
	t.references :product, index: true
    t.references :article, index: true
    t.timestamps null: false
    end
  end
end
