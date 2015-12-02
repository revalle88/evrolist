class ProductProperty < ActiveRecord::Base
  belongs_to :product
  belongs_to :property
  accepts_nested_attributes_for :property
end
