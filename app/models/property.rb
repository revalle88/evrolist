class Property < ActiveRecord::Base
  has_many :productProperties
  has_many :products, through: :productProperties
end
