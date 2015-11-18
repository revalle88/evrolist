module CatalogHelper
	def renderCatSubmenu(cat)
	  htmlData = ""
	  childCats = Category.where(parent_id: cat.id)
	  if childCats.count>0
	  htmlData = htmlData+"<div class='dropdown_4columns'>"
	  childCats.each do |chCat|
		if chCat.name
			htmlData = htmlData +"<li>"+chCat.name+chCat.id+""
			htmlData = htmlData+renderSubmenu(chCat)
			htmlData = htmlData+"</li>"
		end
	  end
	  htmlData = htmlData + "</div>"
	 
	end
	 htmlData.html_safe
	

	end
	def renderProperties(product)
		properties = ProductProperty.where(product_id: product.id)
		htmlData = "<br>"
		properties.each do |prop|
			if prop.stringValue
				propertyName = Property.find(prop.property_id).name
				htmlData = htmlData+propertyName+" : "+prop.stringValue+"<br>"
			end
		end
		htmlData.html_safe
		
	end
	def countProducts(category)
    quantity = Product.where(category_id:category.id).count
    htmlData = "<a href='/catalog/show/"+category.id.to_s+"'>"+category.name;
    if quantity
    	htmlData = htmlData + "("+quantity.to_s+")";
    end
    htmlData = htmlData+"</a>"
    htmlData.html_safe
  end
end
