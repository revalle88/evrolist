#require 'nokogiri'
require 'rest_client'
class MyxmlController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def parseXMLcats
      doc = File.open("blossom.xml") { |f| Nokogiri::XML(f) }
      root = doc.root;
      groups=root.at_xpath("//Классификатор//Группы")
      @rootGroups = groups.element_children

      #@items = root.xpath("//Классификатор//Группы/*")
      

     @cnt =  @rootGroups.count

  end
  def loadCategories(file_name)
    #Rails.logger.debug "loadCategories start"
      @file_name = file_name
      Rails.logger.info "file_name"
      
     
      doc = File.open(file_name) { |f| Nokogiri::XML(f) }
        Rails.logger.info "1"
      doc.remove_namespaces!
     # Rails.logger.info "opened file"
      root = doc.root;
       Rails.logger.info "2"
        groups=root.at_xpath("//Классификатор//Группы")
        @rootGroups = groups.element_children
        @rootGroups.each do |gruppa|
          id1c = gruppa.xpath('Ид').inner_text 
           Rails.logger.info "3"
          catName = gruppa.xpath('Наименование').inner_text
          code1c = gruppa.xpath('Описание').inner_text
          code1c = code1c.partition(" ").first
          if !(Category.exists?(:id1c => id1c)) then
            puts "Category not exists"
            category = Category.new
            category.name = catName.partition(". ").last
            category.id1c = id1c 
            category.code1c = code1c
            category.image_from_url("http://evrolist.ru/components/com_virtuemart/shop_image/category/cat_"+code1c+".jpg")
            category.save
            
            
          else
            puts "Category  exists"
            category = Category.where(:id1c => id1c).first
            category.name = catName.partition(". ").last
            category.id1c = id1c 
            category.code1c = code1c
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
           code1c = gruppa.xpath('Описание').inner_text
            code1c = code1c.partition(" ").first
            if !(Category.exists?(:id1c => id1c)) then
            puts "child category not exists"
            r = Category.find_by_id1c(parent1c)
            category = Category.new
            category.name = catName.partition(". ").last
            puts catName.partition(". ").last
            category.id1c = id1c 
            category.code1c = code1c
            category.parent_id = r.id
            category.image_from_url("http://evrolist.ru/components/com_virtuemart/shop_image/category/cat_"+code1c+".jpg")
            category.save
            
            r.reload
            else
              puts "child category exists"
            r = Category.find_by_id1c(parent1c)
            category = Category.where(:id1c => id1c).first
            category.name = catName.partition(". ").last
             puts catName.partition(". ").last
            category.id1c = id1c 
            category.code1c = code1c
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

    def loadGoods(file_name, folder)
      doc = File.open(file_name) { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!
      root = doc.root;
        goods=root.xpath("//Каталог//Товары")
        @childGoods = goods.children
        @childGoods.each do |good|

          id1c = good.xpath('Ид').inner_text 
          if !(id1c=="") then
           puts "id1c"
          puts id1c
          goodName = good.xpath('Наименование').inner_text
           puts "goodName"
        puts goodName
          if !(Product.exists?(:id1c => id1c)) then
          puts "Product not exists"
          product = Product.new
        else
        puts "Product exists"
         product = Product.where(:id1c => id1c).first
        end
        product.name = goodName
        product.descriptionFull = goodName
        product.descriptionMin = goodName
        product.id1c = id1c
        product.articul = good.xpath('Артикул').inner_text
        parentid1c = good.xpath('Группы').xpath('Ид').inner_text 
        if (Category.exists?(:id1c => parentid1c)) then
          product.category = Category.find_by_id1c(parentid1c)

        end
        puts "file_name"
        puts file_name
        puts "id1c"
        puts id1c
        code1c = ""
        image1c = ""
        image1c = good.xpath('Картинка').inner_text
        img_path = Dir.glob(folder+"/"+image1c)
        puts "описание файла"
              puts image1c
              puts "IMAGE 1c folder"
              puts folder
        puts img_path
        puts "THIS!!!"
          puts    folder+"/"+image1c
     # f = File.new(folder+"/"+image1c)
      product.image = nil
       #product.image = File.open(folder+"/"+image1c)

      # f.close

        if !(image1c.empty?) then
              #File.open(img_path) do |f|
             File.open(folder+"/"+image1c) do |f|
                  product.image = f 
                   f.close
              end
        end
        #код 1с + загрузка картинки
        good.xpath('ЗначенияРеквизитов').children.each do |req|
          
            if req.xpath('Наименование').inner_text == "Код" then
              code1c = req.xpath('Значение').inner_text
              product.code1c = code1c
              puts 'код1с'
               puts code1c
            end 
            
          end



            product.save
          end
          #end #
        end #@childGoods.each do |good|

    end

    def loadProductImages(file_name)
      doc = File.open(file_name) { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!
      root = doc.root;
        goods=root.xpath("//Каталог//Товары")
        @childGoods = goods.children
        @childGoods.each do |good|
        id1c = good.xpath('Ид').inner_text 
        goodName = good.xpath('Наименование').inner_text
        if (Product.exists?(:id1c => id1c)) then
          product = Product.find_by_id1c(id1c)
          product.image = nil
          product.save
          good.xpath('ЗначенияРеквизитов').children.each do |req|
            if req.xpath('Наименование').inner_text == "Код" then
              product.image_from_url("http://evrolist.ru/components/com_virtuemart/shop_image/product/my_"+req.xpath('Значение').inner_text+".jpg")
            end 
          end
          product.save
        end
      end
    end

    def deleteImageTest
      product = Product.find(3708)
      product.image = nil
      product.save
    end

    def updatePrices(file_name)

      doc = File.open(file_name) { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!
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
    #     product = Product.find_by_id1c(id1c)
    #         ##TODO
    #         firstPrice = offer.xpath('Цены').children.first
    #         puts "цена" + firstPrice.xpath('ЦенаЗаЕдиницу').inner_text
    #     product.price=firstPrice.xpath('ЦенаЗаЕдиницу').inner_text.to_f
            
          
    #     product.save 
    #   end
    # end

      #@cntPrices =  @childPrices.count


    end

    def updateRests(file_name)
      doc = File.open(file_name) { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!
      root = doc.root;
      testOffers = root.xpath("//ПакетПредложений//Предложения//Предложение")
       testOffers.each do |testOffer|
          id1c = testOffer.xpath('Ид').inner_text 

          puts "Количество"
          
         # puts id1c
           if (Product.exists?(:id1c => id1c)) then
            product = Product.find_by_id1c(id1c)
             val = testOffer.xpath('Остатки').xpath('Остаток').xpath('Количество').inner_text.to_f
             product.rest = val
             puts "val"
             product.save
              puts "saved"


              #product = Product.find_by_id1c(id1c)
             # testRests = testOffer.xpath('Остатки').children
              #testRests.each do |testRest|
              #  val = testRest.xpath('Количество').inner_text.to_f
               #  puts "Rests!!!!!!!!!!!!!!!!!!!"
               #  puts val
                # puts testOffer.xpath('Количество').inner_text
                # product.rest = val 
                # product.save
                 #val = val + testRest.xpath('Склад//Количество').inner_text.to_f
                 #puts testRest.xpath('Склад//Количество').inner_text

             # end
             
              
             
           end
         
       end
    end

    def get_file_from_1c
   puts "get_file_from_1c get_file_from_1c get_file_from_1c get_file_from_1c get_file_from_1c"
   FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/1cExchange/*"))
   request.body.rewind
   tmp_file = "#{Rails.root}/tmp/1cExchange/import.rar"
   puts tmp_file
    File.open(tmp_file, 'wb') do |f|
    f.write  request.body.read
    puts "file saved"
   end
   #rar x archive.rar path/to/extract/to
   system("unrar x "+tmp_file+" #{Rails.root}/tmp/1cExchange/")
    #system('unrar l '+tmp_file)
     puts "file unpacked!!!!"

     files = Dir.glob("#{Rails.root}/tmp/1cExchange/1/webdata/000000002/goods/1/*.xml")
     puts files[1]
     file_name = files[2]


     ###############load goods######################
     loadGoods(file_name)



file_name = files[1]
     #load goods################################

     updatePrices(file_name)
   #############################
   file = request.body.read
   #file.force_encoding('UTF-8')
   puts "1"
  return nil if file.blank?
  puts "2"
      temp = Tempfile.new(['import', '.rar'])
      puts "3"
      temp.write file
      puts "4"
      puts temp.path
      temp.rewind
      temp
  end

  def send_zip
    RestClient.get 'http://localhost:3000/'
   #RestClient.post 'http://localhost:3000/get_file_from_1c', :name_of_file_param => File.new('/home/vladimir/bszip.zip')
   # RestClient.post('http://localhost:3000/get_file_from_1c', 
   #:name_of_file_param => File.new('/home/vladimir/bszip.zip'))
   
  end

  def import_all
   FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/1cExchange"))
   Dir.mkdir "#{Rails.root}/tmp/1cExchange"
   request.body.rewind
   tmp_file = "#{Rails.root}/tmp/1cExchange/import.rar"
   puts tmp_file
    File.open(tmp_file, 'wb') do |f|
    f.write  request.body.read
    puts "file saved"
   end
  system("unzip "+tmp_file+" -d #{Rails.root}/tmp/1cExchange/")
   #system("rar x "+tmp_file+" #{Rails.root}/tmp/1cExchange/")
 
     puts "file unpacked!!!!"
     catFiles = Dir.glob("#{Rails.root}/tmp/1cExchange/export1/1/webdata/000000002/*.xml").sort
     file_name = catFiles[0]
     puts "file xml for categories"
     puts file_name
     #loadCategories(file_name)

      Dir.glob("#{Rails.root}/tmp/1cExchange/export1/1/webdata/000000002/goods/*") do |folder|
        files = Dir.glob(folder +"/*.xml").sort
         puts "files[0]"
         puts files[0]
         puts "files[1]"
         puts files[1]
         puts "files[2]"
         puts files[2]
        file_name = files[0]
         loadGoods(file_name)
         #loadProductImages(file_name)
         file_name = files[1]
        #updatePrices(file_name)
         file_name = files[2]
         updateRests(file_name)


   
        #puts folder
      end
      # puts "Entries"
    # puts Dir.glob("#{Rails.root}/tmp/1cExchange/1/webdata/000000002/goods/*").entries()

  end

  def webdataImport
    

     catFiles = Dir.glob("/home/deploy/1cExchange/webdata/000000001/*.xml").sort
       @teststr = "#{Rails.root}"
       # Rails.logger.info @teststr
     file_name = catFiles[0]
     @teststr = catFiles[0]
        # Rails.logger.info "THIS"
        # Rails.logger.info @teststr
     #logger.debug file_name
     puts "file xml for categories"
     puts file_name
     #loadCategories(file_name)

    Dir.glob("/home/deploy/1cExchange/webdata/000000001/goods/*") do |folder|
        files = Dir.glob(folder +"/*.xml").sort
         puts "files[0]"
         puts files[0]
         puts "files[1]"
         puts files[1]
         puts "files[2]"
         puts files[2]
        file_name = files[0]
         
         loadGoods(file_name, folder)
         #loadProductImages(file_name)
         file_name = files[1]
         updatePrices(file_name)
         file_name = files[2]
         updateRests(file_name)


   
        #puts folder
      end


  end
  
end