class CategoriesController < ApplicationController
  layout 'admin'
  before_filter :verify_is_admin
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @rootCats = Category.where(parent_id: nil)
    @categories = Category.search(params[:search]).page(params[:page]).per_page(5)
  #  @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @childCats = Category.where(parent_id: params[:id])
  end

  # GET /categories/new
  def new
    #@cat_options = Category.all.map{|c| [ c.name, c.id ] }
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    if @category.parent_id
    @r = Category.find(@category.parent_id)
    end

    respond_to do |format|
      if @category.save

        if @r
        @r.reload
      end
          @categories = Category.search(params[:search]).page(params[:page]).per_page(5)
        format.html { render action: 'index', notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :id1c, :parent_id, :image, :search)
    end

    private

def verify_is_admin
  (current_user.nil?) ? redirect_to(new_user_session_path) : (redirect_to(new_user_session_path) unless current_user.admin?)
end

end
