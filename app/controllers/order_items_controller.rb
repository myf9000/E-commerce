class OrderItemsController < ApplicationController
  before_action :find_resource, only: [:edit, :update, :destroy]
  before_action :load_order, only: [:create, :update, :buy]

  layout "layout_for_form" 
  
  def edit
  end

  def create
    if current_user.info != nil 
      @order_item = @order.order_items.find_by(product_id: params[:product_id]) ||  @order.order_items.new(quantity: 1, product_id: params[:product_id]) 
      @order_item.check_new_record(@order_item)
        if current_user != @order_item.product.user
          if @order_item.quantity <= @order_item.product.stock
            if @order_item.save 
              redirect_to @order, notice: 'Order item was successfully created.' 
            else
              redirect_to :back, notice: 'Order item was not created.'  
            end
          else 
            redirect_to :back , notice: 'Too big quantity!' 
          end
        else
          redirect_to :back , notice: 'You can not buy your product' 
        end
    else 
      redirect_to new_info_path, notice: 'Fill your info' 
    end
  end

  # refactor codu i przeklikanie, nastepnie testy - Happy New Year

  def update
    if params[:order_item][:quantity].to_i == 0
      @order_item.destroy
      redirect_to @order, notice: 'Order item was successfully destroyed.'
    elsif @order_item.update(order_item_params) && @order.check_in == true
      redirect_to @order, notice: 'Order item was successfully updated.'
    else
      flash[:warning] = 'Too big quantity!' 
      render :edit
    end
  end

  def destroy
    @order = @order_item.order
    @order_item.destroy
    redirect_to @order, notice: 'Order item was successfully destroyed.' 
  end
  
  def buy
    if @order.check_in == true
      @order.order_items.each do |f|
        check = f.product.stock - f.quantity
        if check > 0
          f.product.stock = check
        elsif check == 0
          f.product.active = false
          f.product.stock = check
        end
        f.product.save
      end
      @order.status = "submitted"
      @order.save
      redirect_to @order, notice: 'You buyed' 
    else
      redirect_to :back, notice: 'To big quantity'
    end
  end

  def product_orders
    @order_item = OrderItem.find(params[:id])
    type = params[:type]

    @order = Order.find(@order_item.order_id)
    if type == "paid"
      @order.status = "paid"
    elsif type == "sent"
      @order.status = "sent"
    elsif type == "delivered"
      @order.status = "delivered"
    end
    @order.save
    redirect_to user_path(current_user.id)
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
      params.require(:order_item).permit(:product_id, :order_id, :quantity)
    end
end