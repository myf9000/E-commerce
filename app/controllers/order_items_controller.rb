class OrderItemsController < ApplicationController
  before_action :find_resource, only: [:edit, :update, :destroy, :product_orders]
  before_action :load_order, only: [:create, :update, :buy]
  
  layout "layout_for_form" 
  
  def edit
  end

  def create
    @order_item = item_set
    @order_item.check_new_record
    if @order_item.is_ok?(current_user)
      @order_item.save 
      redirect_to @order, notice: 'Order item was successfully created.' 
    else
      redirect_to :back, notice: 'Error - you want to buy your own product, or product quantity is too big!' 
    end
  end

  def update
    if params[:order_item][:quantity].to_i == 0
      @order_item.destroy
      redirect_to @order, notice: 'Order item was successfully destroyed.'
    elsif @order_item.update(order_item_params) && @order.check_in 
      redirect_to @order, notice: 'Order item was successfully updated.'
    else
      flash.now[:warning] = 'Too big quantity!' 
      render :edit
    end
  end

  def destroy
    @order = @order_item.order
    @order_item.destroy
    redirect_to @order, notice: 'Order item was successfully destroyed.' 
  end
  
  def buy
    if @order.check_in 
      @order.buyed
      redirect_to @order, notice: 'You buyed' 
    else
      redirect_to @order, notice: 'To big quantity'
    end
  end

  def product_orders
    @order = @order_item.order
    @order.set_status(params[:type])
    redirect_to current_user
  end

  private

    def load_order
      @order = Order.find_by(id: session[:order_id], status: "unsubmitted") || current_user.orders.build(status: "unsubmitted")
      if @order.new_record?
        @order.save!
        session[:order_id] = @order.id
      end
    end

    def order_item_params
      params.require(:order_item).permit(:quantity)
    end

    def item_set
      @order.order_items.find_by(product_id: params[:product_id]) || @order.order_items.new(quantity: 1, product_id: params[:product_id]) 
    end
end