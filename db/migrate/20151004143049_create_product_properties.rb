class CreateProductProperties < ActiveRecord::Migration
  def change
    create_table :product_properties do |t|
      t.references :product, index: true
      t.references :property, index: true
      t.string :stringValue
      t.float :floatValue

      t.timestamps
    end
  end
end
