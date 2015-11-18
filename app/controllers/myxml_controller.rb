require 'nokogiri'
class MyxmlController < ApplicationController
	def parseXMLcats
      doc = File.open("blossom.xml") { |f| Nokogiri::XML(f) }
      root = doc.root;
      groups=root.at_xpath("//Классификатор//Группы")
      @rootGroups = groups.element_children

      #@items = root.xpath("//Классификатор//Группы/*")
      

	   @cnt =  @rootGroups.count

  end
  def loadCategories
  		doc = File.open("blossom.xml") { |f| Nokogiri::XML(f) }
  		root = doc.root;
      	groups=root.at_xpath("//Классификатор//Группы")
      	@rootGroups = groups.element_children
      	@rootGroups.each do |gruppa|
      		id1c = gruppa.xpath('Ид').inner_text 
      		catName = gruppa.xpath('Наименование').inner_text
      		if !(Category.exists?(:id1c => id1c)) then
      			puts "Category not exists"
      			category = Category.new
      			category.name = catName
      			category.id1c = id1c 
      			category.save
      		end
      		loadChildCategories(gruppa)



      	end
    end 

    def loadChildCategories(cat)
    	parent1c = cat.xpath('Ид').inner_text 
    	puts "parent cat id  " + parent1c
    	groups=cat.xpath('Группы')
        childGroups = groups.children
        childGroups.each do |gruppa| 
        	
    		id1c = gruppa.xpath('Ид').inner_text 
      		catName = gruppa.xpath('Наименование').inner_text
      			if !(Category.exists?(:id1c => id1c)) then
      			puts "child category not exists"
      			r = Category.find_by_id1c(parent1c)
      			category = Category.new
      			category.name = catName
      			category.id1c = id1c 
      			category.parent_id = r.id
      			category.save
      			
      			r.reload
      		end
      		loadChildCategories(gruppa)
      		

      	end
    
    end	


     def parseGoods
      doc = File.open("import.xml") { |f| Nokogiri::XML(f) }
      root = doc.root;
      goods=root.xpath("//Каталог//Товары")
      @childGoods = goods.children
      @cnt =  @childGoods.count
      #childGoods.each do |good|
      docPrices = File.open("prices.xml") { |f| Nokogiri::XML(f) }
      pricesroot = docPrices.root;
      prices=pricesroot.xpath("//ПакетПредложений//Предложения")
      @childPrices = prices.children
      @cntPrices =  @childPrices.count

      

      #end 
          
    end

    def loadGoods
    	doc = File.open("import.xml") { |f| Nokogiri::XML(f) }
  		root = doc.root;
      	goods=root.xpath("//Каталог//Товары")
      	@childGoods = goods.children
      	@childGoods.each do |good|
      		id1c = good.xpath('Ид').inner_text 
      		goodName = good.xpath('Наименование').inner_text
      		if !(Product.exists?(:id1c => id1c)) then
      			puts "Product not exists"
				product = Product.new
				product.name = goodName
				product.descriptionFull = goodName
				product.descriptionMin = goodName
				product.id1c = id1c
				product.articul = good.xpath('Артикул').inner_text
				parentid1c = good.xpath('Группы').xpath('Ид').inner_text 
				if (Category.exists?(:id1c => parentid1c)) then
					product.category = Category.find_by_id1c(parentid1c)

				end

      			product.save
      		end
      	end

    end

    def loadProductImages
    	doc = File.open("import.xml") { |f| Nokogiri::XML(f) }
  		root = doc.root;
      	goods=root.xpath("//Каталог//Товары")
      	@childGoods = goods.children
      	@childGoods.each do |good|
      	id1c = good.xpath('Ид').inner_text 
      	goodName = good.xpath('Наименование').inner_text
      	if (Product.exists?(:id1c => id1c)) then
      		product = Product.find_by_id1c(id1c)
      		good.xpath('ЗначенияРеквизитов').children.each do |req|
      			if req.xpath('Наименование').inner_text == "Код" then
      				product.image_from_url("http://evrolist.ru/components/com_virtuemart/shop_image/product/my_"+req.xpath('Значение').inner_text+".jpg")
      			end 
      		end
      		product.save
      	end
      end
    end

    def updatePrices
      doc = File.open("prices.xml") { |f| Nokogiri::XML(f) }
      root = doc.root;
      test = root.xpath('ПакетПредложений')
      
      puts "ИД Пакета предложений: " + test.xpath('Ид').inner_text
      offers=root.xpath("//ПакетПредложений//Предложения")
      testOffers = root.xpath("//ПакетПредложений//Предложения//Предложение")

      testOffers.each do |testOffer|

          puts "ИД предложения 2  " + testOffer.xpath('Ид').inner_text 
          id1c = testOffer.xpath('Ид').inner_text 
          if (Product.exists?(:id1c => id1c)) then
            product = Product.find_by_id1c(id1c)
            testPrices = testOffer.xpath('Цены').children
            hhh = testPrices[1]
            puts "первая цена " + hhh.xpath('ЦенаЗаЕдиницу').inner_text
            product.price=hhh.xpath('ЦенаЗаЕдиницу').inner_text.to_f
            product.save 
            #testPrices.each do |testPrice|
            #   puts testPrice.xpath('ЦенаЗаЕдиницу').inner_text
            #end

          end
      end


    #   childOffers = offers.children
    #   @cnt =  childOffers.count
    #   puts "Количество предложений: " + @cnt.to_s
    #    puts "Количество предложений 2: " + testOffers.count.to_s
    #   childOffers.each do |offer|
    #   id1c = offer.xpath('Ид').inner_text 
    #   puts "ИД предложения " + offer.content
    #   if (Product.exists?(:id1c => id1c)) then
    #   	product = Product.find_by_id1c(id1c)
    #   	 		##TODO
    #         firstPrice = offer.xpath('Цены').children.first
    #         puts "цена" + firstPrice.xpath('ЦенаЗаЕдиницу').inner_text
    #   	product.price=firstPrice.xpath('ЦенаЗаЕдиницу').inner_text.to_f
      			
      		
    #   	product.save 
    #   end
    # end

      #@cntPrices =  @childPrices.count


    end
  
end