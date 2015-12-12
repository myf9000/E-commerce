class ProductsController < ApplicationController
  impressionist :actions=>[:show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_index, only: [:index]

  #load_and_authorize_resource

  # GET /products
  # GET /products.json
  def searching
    @search = Product.search(params[:q])
    @products = @search.result
  end       

  # GET /products/1
  # GET /products/1.json
  def show
    #impressionist(@product)
    @owner = owner(@product.user_id)
    @category = find_category(@product.category)
    @subcategory = find_category(@product.subcategory)
  end


  def index  
    if params[:search]
      @products = Product.title_like("%#{params[:search]}%").order('title').all.paginate(:page => params[:page], :per_page => 3)
    end
    render layout: "layout_for_index" 
  end

  # GET /products/new
  def new
    @product = current_user.products.build
    render layout: "layout_for_form" 
  end

  # GET /products/1/edit
  def edit
    render layout: "layout_for_form" 
  end

  def sort_list
    if params[:sort] 
      @products = Product.ordered_by(params[:sort]).paginate(:page => params[:page], :per_page => 3)
    end
  end


  # POST /products
  # POST /products.json
  def create
     @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
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
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product was deleted"  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :price, :description, :avatar, :stock, :shipment, :company, :technical, :category, :subcategory, pictures_attributes: [:id, :pict, :_destroy])
    end

    def set_index
      @products = Product.all.paginate(:page => params[:page], :per_page => 3)
      t = []
      @products.all.each { |f| t << f.title }
      gon.titles = t.uniq
    end   
end
