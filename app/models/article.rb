class Article < ActiveRecord::Base
	has_attached_file :image, styles: { thumb: "100x100#", weekchoice: "195x150#"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    has_many :articleProducts
    has_many :products, through:  :articleProducts
end
