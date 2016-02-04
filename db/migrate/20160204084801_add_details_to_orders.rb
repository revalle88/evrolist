class AddDetailsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :surname, :string
    add_column :orders, :email, :string
    add_column :orders, :phone, :string
    add_column :orders, :mphone, :string
    add_column :orders, :city, :string
    add_column :orders, :street, :string
    add_column :orders, :house, :string
    add_column :orders, :korpus, :string
    add_column :orders, :floor, :integer
    add_column :orders, :entrance, :integer
    add_column :orders, :flat, :string
    add_column :orders, :comment, :text
  end
end
