class AddCode1cToProducts < ActiveRecord::Migration
  def change
    add_column :products, :code1c, :string
  end
end
