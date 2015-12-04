class ProductsController < ApplicationController
    layout 'admin'
    before_filter :verify_is_admin
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    #@products = Product.all
     @products = Product.search(params[:search]).page(params[:page]).per_page(5)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @pp = ProductProperty.where(product_id: params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @pp = ProductProperty.where(product_id: params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def newatt

    @properties = Property.all
    @product_id = params[:id]
    #@pp = ProductProperty.new


  end

  def addatt
    puts params
    @pp = ProductProperty.new
    @pp.property_id = params[:property_id]
    @pp.stringValue = params[:stringValue]
    @pp.product_id = params[:product_id]
    @pp.save
    redirect_to :action => "edit", :id => params[:product_id]
  end

  def deleteatt
    puts "DELETE ATT"
    puts params
    @pp = ProductProperty.find(params[:pp_id])
    @pp.destroy
     redirect_to :action => "edit", :id => params[:product_id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :id1c, :descriptionFull, :descriptionMin, :articul, :baseUnit, :shtrihkod, :standart, :price, :rest, :category_id, :image)
    end

    private

def verify_is_admin
  (current_user.nil?) ? redirect_to(new_user_session_path) : (redirect_to(new_user_session_path) unless current_user.admin?)
end




end
