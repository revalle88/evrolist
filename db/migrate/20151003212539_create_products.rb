class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :id1c
      t.text :descriptionFull
      t.text :descriptionMin
      t.string :articul
      t.string :baseUnit
      t.string :shtrihkod
      t.string :standart
      t.decimal :price
      t.float :rest
      t.references :category, index: true

      t.timestamps
    end
  end
end
