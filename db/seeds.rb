# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
OrderStatus.delete_all
OrderStatus.create! id: 1, name: "в корзине"
OrderStatus.create! id: 2, name: "оплачено"
OrderStatus.create! id: 3, name: "погружено"
OrderStatus.create! id: 4, name: "отменено"