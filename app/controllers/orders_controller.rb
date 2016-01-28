class OrdersController < ApplicationController
  before_action :find_resource, only: [:destroy, :show]
  before_action :order_privigles, only: [:destroy, :show]
  
  layout "layout_for_form" 

  def show
  end

  def destroy
    @order.destroy
    redirect_to products_path, alert: 'Order was successfully destroyed.' 
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end

    def order_privigles
      redirect_to root_url, alert: 'You can not see this!' if current_user != @order.user
    end
end
