module CategoriesHelper
	def renderSubmenu(cat)
	  htmlData = ""
	  childCats = Category.where(parent_id: cat.id)
	  if childCats.count>0
	  htmlData = htmlData+"<div class='dropdown_4columns'>"
	  htmlData = htmlData+"<div class='col_4'><h2>"+cat.name+"</h2></div>"
	  #htmlData = htmlData+
	  childCats.each do |chCat|
		if chCat.name
			htmlData = htmlData + "<div class = 'subcat'>"
			htmlData = htmlData + "<a href='/catalog/show/"+chCat.id.to_s+"'>"+chCat.name+"</a>"
			htmlData = htmlData + renderSubCats(chCat) + "</div>"
			
			#htmlData = htmlData + "<li><a href='/catalog/show/"+chCat.id.to_s+"'>"+chCat.name+"</a>"
			#htmlData = htmlData+renderSubmenu(chCat)
			#htmlData = htmlData+"</li>"
		end
	  end
	  htmlData = htmlData + "</div>"
	 
	end
	 htmlData.html_safe
	

	end

	def renderSubCats(cat)
		 htmlData = ""
	  childCats = Category.where(parent_id: cat.id)
	  if childCats.count>0
	  	htmlData = htmlData +"<ul class = 'subcatList'>"
	  	childCats.each do |chCat|
		if chCat.name
			htmlData = htmlData + "<li class = 'subcatListLi'>"+"<a href='/catalog/show/"+chCat.id.to_s+"'>"+chCat.name+"</a>"+"</li>";

			end
	  end
	  htmlData = htmlData + "</ul>"
	 
	end
	 htmlData.html_safe

	end
end
