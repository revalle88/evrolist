class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items

	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @current_order = current_order
    #для робокассы
    @pay_desc = Hash.new
      @pay_desc['mrh_url']   = "https://auth.robokassa.ru/Merchant/Index.aspx"
      @pay_desc['mrh_login'] = "evrolist"
      @pay_desc['mrh_pass1'] = "Test12345678"
      @pay_desc['inv_id']    = current_order.id
      @pay_desc['inv_desc']  = ""
      @pay_desc['out_summ']  = current_order.subtotal
      @pay_desc['shp_item']  = current_order.id
      @pay_desc['in_curr']   = "WMRM"
      @pay_desc['culture']   = "ru"
      @pay_desc['encoding']  = "utf-8"
      @pay_desc['isTest']  = "1"
      # расчет контрольной суммы
      @pay_desc['crc'] = get_hash(@pay_desc['mrh_login'], 
                                           @pay_desc['out_summ'],
                                           @pay_desc['inv_id'], 
                                           @pay_desc['mrh_pass1'], 
                                           "Shp_item=#{@pay_desc['shp_item']}")     
    

    render layout: "catalog"
  end

   def get_hash(*s)
    Digest::MD5.hexdigest(s.join(':'))
  end
end
