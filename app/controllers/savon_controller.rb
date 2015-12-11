require 'savon' 
class SavonController < ApplicationController
  def savontest
  	@wsdl="http://list-lider.ru:18060/ut/ws/Exchange?wsdl"
	@basic_auth=["Активный менеджер",""]
	@headers={"Authorization" => "Basic"}
	@client = Savon.client do |globals|
	  globals.wsdl @wsdl
	  globals.basic_auth @basic_auth
	  globals.headers @headers
	end
	begin
		@operations = @client.operations
		
	rescue Exception => e
		@errormessage =  e.message
	end

	begin 
		response = @client.call(:get_functional_option, message: {name: "ПрефиксИнформационнойБазы" })
		@savonresponse = response.body
	rescue Exception => e1
		@errormessage1 =  e1.message
	end


	begin 
		response = @client.call(:GetFunctionalOption, message: {name: "ПрефиксИнформационнойБазы" })
		@savonresponse = response.body
	rescue Exception => e2
		@errormessage2 =  e2.message
	end


  
  end
end