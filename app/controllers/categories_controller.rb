class CategoriesController < ApplicationController
  before_action :find_resource, only: [:show, :destroy, :edit, :update]
  load_and_authorize_resource

  def index
   @category = nil
   @categories = Category.only_category
  end

  def show
  	@categories = @category.subcategories
  	render 'index'
  end

  def create
  	@category = Category.new(category_params)
  	@category.parent_id = params[:parent_id]
  	if @category.save
  		redirect_to @category
  	else
  		render :new
  	end
  end

  def new
    @category = Category.new
  end

  def destroy
  	@category.destroy
  	redirect_to categories_path
  end

  def edit
  end

  def update
  	if @category.update(category_params)
  	  redirect_to @category
  	else
  	  render :edit
  	end
  end


  private

  def category_params
  	params.require(:category).permit(:name)
  end
 
end
