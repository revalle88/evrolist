require 'nokogiri'
module MyxmlHelper
	def printChildCats(cat)
			htmlData = ""
			groups=cat.xpath('Группы')
            childGroups = groups.children
            childGroups.each do |gruppa| 
            groupName = gruppa.xpath('Наименование').inner_text 
			htmlData = htmlData + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ groupName +"<br>"
			htmlData = htmlData+printChildCats(gruppa)+"<br>"
		end
	htmlData.html_safe
	end
end