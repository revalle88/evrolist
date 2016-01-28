class AddCode1cToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :code1c, :string
  end
end
