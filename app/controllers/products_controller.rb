class ProductsController < ApplicationController
  impressionist actions: [:show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_index, only: :index

  def show
    @category = find_category(@product.category)
    @subcategory =  find_category(@product.subcategory)
    impressionist(@product) # configuration issue with squeel
  end
 

  def index  
    @search = Product.search(params[:q])
    @products = params[:q] ? @search.result : Product.find_products(params)

    render layout: "layout_for_index"
  end

  def new
    @product = current_user.products.build
    render layout: "layout_for_form"
  end

  def edit
    render layout: "layout_for_form"
  end

  def create
     @product = current_user.products.build(product_params)
      if @product.save
        redirect_to @product, notice: 'Product was successfully created.' 
      else
        render :new 
      end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.' 
    else
      render :edit 
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, alert: "Product was deleted"  
  end

  private
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :price, :description, :avatar, :stock, :shipment, :con, :company, :technical, :category, :subcategory, pictures_attributes: [:id, :pict, :_destroy])
    end

    def set_index
      @products = Product.all
      gon.titles = @products.pluck(:title).uniq
    end   
end
