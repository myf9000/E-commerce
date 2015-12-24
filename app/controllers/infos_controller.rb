class InfosController < ApplicationController
  before_action :find_resource, only: [:show, :destroy, :edit, :update]
  before_action :info_params, only: [:create, :update]
  layout "layout_for_form" 

  def new
    @info = current_user.build_info(params[:info])
  end

  def show
  end

  def create
    @info = current_user.build_info(info_params)
    if @info.save
      redirect_to @info, notice: 'Info was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @info.update(info_params)
      redirect_to @info, notice: 'Info was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @info.destroy
    redirect_to user_path(current_user), notice: 'Product was successfully destroyed.'
  end

  private

  def info_params
    params.require(:info).permit(:city, :code, :flat, :street, :first_name, :last_name, :card_code)
  end
end
