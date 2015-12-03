class ProductsController < ApplicationController
  impressionist :actions=>[:show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.paginate(:page => params[:page], :per_page => 2)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    #impressionist(@product)
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
  end

  def sort_list
    if params[:sort] == "DESC"
      @products = Product.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:sort] == "ASC"
      @products = Product.all.order("created_at ASC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:sort] == "small"
      @products = Product.all.order("price ASC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:sort] == "big"
      @products = Product.all.order("price DESC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:sort] == "top"
      @products = Product.all.order("viewed_count ASC").paginate(:page => params[:page], :per_page => 3)
    else
      @products = Product.all.paginate(:page => params[:page], :per_page => 3)
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
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :price, :description, :avatar, :stock, :category, :subcategory)
    end
end
