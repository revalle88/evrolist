class Category < ActiveRecord::Base
	has_attached_file :image, styles: { large: "600x800>", medium: "250x250>", thumb: "150x150#"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	acts_as_nested_set

	def self.search(search)
     
  		if search

     		self.where("lower(name) like ?", "%#{search}%".downcase)
 		 else
    		self.all
  		end
	end
end
