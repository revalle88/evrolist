module ApplicationHelper
	def renderSubmenu(cat)
	  htmlData = ""
	  childCats = Category.where(parent_id: cat.id)
	  if childCats.count>0
	  htmlData = htmlData+"<ul>"
	  childCats.each do |chCat|
		if chCat.name
			htmlData = htmlData +"<li><a href='/catalog/show/"+chCat.id+"'>"+chCat.name+chCat.id+"</a>"
			htmlData = htmlData+renderSubmenu(chCat)
			htmlData = htmlData+"</li>"
		end
	  end
	  htmlData = htmlData + "</ul>"
	 
	end
	 htmlData.html_safe
	

	end
end
