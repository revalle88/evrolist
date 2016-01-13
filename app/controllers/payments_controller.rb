class PaymentsController < ApplicationController
  def pay
  	@pay_desc = Hash.new
      @pay_desc['mrh_url']   = "https://auth.robokassa.ru/Merchant/Index.aspx"
      @pay_desc['mrh_login'] = "evrolist"
      @pay_desc['mrh_pass1'] = "Test12345678"
      @pay_desc['inv_id']    = 0
      @pay_desc['inv_desc']  = "test"
      @pay_desc['out_summ']  = "100"
      @pay_desc['shp_item']  = "1"
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
    
  end
  

  def result
    pass2 = "Test87654321"
    crc = get_hash(params['OutSum'], 
                            params['InvId'], 
                            pass2,
                           "Shp_item=#{params['Shp_item']}")
    @result = "FAIL"
    puts "params OutSum, InvId, pass2, shp_item, signature, crc"
    puts params[:OutSum]
    puts params[:InvId]
    puts pass2
    puts params[:Shp_item]
    puts params[:SignatureValue]
    puts crc
    begin
      # проверяем контрольную сумму, чтобы нас не похекали
      break if params['SignatureValue'].blank? || crc.casecmp(params['SignatureValue']) != 0
      @order = Order.where(:id => params['Shp_item']).first
      # ищем заказ
      break if @order.blank? || @order.subtotal != params['OutSum'].to_f
      # делаем с заказом то что нам нужно
      
      @order.order_status_id = 2
      @order.save
      Rails.logger.info "SignatureValue: "
      Rails.logger.info params['SignatureValue']
       Rails.logger.info "crc: "
      Rails.logger.info crc

      # ...
      # говорим робокассе, что все хорошо
      @result = "OK#{params['InvId']}"
    end while false
  end


  def success
  end

  def fails
  end
  def get_hash(*s)
    Digest::MD5.hexdigest(s.join(':'))
  end
end
