class OrdersController < ApplicationController
  before_action :find_resource, only: [:destroy, :show]
  load_and_authorize_resource

  def show
    render layout: "layout_for_form" 
  end

  def destroy
    @order.destroy
    redirect_to products_path, notice: 'Order was successfully destroyed.' 
  end

  private
    def order_params
      params.require(:order).permit(:user_id, :status)
    end
end
