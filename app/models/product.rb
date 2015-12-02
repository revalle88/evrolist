require "net/http"
class Product < ActiveRecord::Base
  has_attached_file :image, styles: { large: "600x800>", medium: "250x250>", thumb: "150x150#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :category
  has_many :productProperties
  has_many :properties, through:  :productProperties
  has_many :order_items

  accepts_nested_attributes_for :productProperties

  
  

  def image_from_url(url)
  	checkurl = URI.parse(url)
	req = Net::HTTP.new(checkurl.host, checkurl.port)
	res = req.request_head(checkurl.path)
    if res.code == "200" then self.image = open(url)
    end
  end


def self.search(search)
     
  if search

     self.where("lower(name) like ?", "%#{search}%".downcase)
  else
    self.all
  end
end
end
