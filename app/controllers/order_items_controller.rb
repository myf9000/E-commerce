class OrderItemsController < ApplicationController
  before_action :find_resource, only: [:edit, :update, :destroy]
  before_action :load_order, only: [:create, :update, :buy, :check_in]

  def edit
    @product_id = @order_item.product_id
    render layout: "layout_for_form" 
  end

  def create
    @order_item = @order.order_items.find_by(product_id: params[:product_id]) ||  @order.order_items.new(quantity: 1, product_id: params[:product_id]) 
    @order_item.check_new_record(@order_item)
    if !current_user != @order_item.product.user
      if @order_item.save 
        redirect_to @order, notice: 'Order item was successfully created.' 
      else
        redirect_to :back, notice: 'Order item was not created.'  
      end
    else
      redirect_to :back , notice: 'You can not buy your product' 
    end
  end

  def update
    if check_in
      if params[:order_item][:quantity].to_i == 0
        @order_item.destroy
        redirect_to @order, notice: 'Order item was successfully destroyed.'
      elsif @order_item.update(order_item_params)
        redirect_to @order, notice: 'Order item was successfully updated.'
      else
        render :edit, notice: 'Order item was not updated.' 
      end
    else 
      render :edit, notice: "Quantity is wrong!"
    end
  end

  def destroy
    @order = @order_item.order
    @order_item.destroy
    redirect_to @order, notice: 'Order item was successfully destroyed.' 
  end
  # order do scope
  def buy
    if @order.total == 0
      @order.destroy
      redirect_to products_path, notice: "You can buy nothing!"
    else
      @order.status = "submitted"
      @order.save
      @order.order_items.each do |f|
        f.product = Product.find(f.product_id)
        f.product.stock = f.product.stock - f.quantity
        if f.product.stock == 0
          f.product.active = false
        end
        f.product.save
      end
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

    def check_in
      x = true
      @order.order_items.each do |f|
        product = Product.find(f.product_id)
        check = product.stock - f.quantity
        if check >= 0
          if check == 0
            product.active = false
          end
          product.stock = check
          product.save
        else 
          x = false
        end
      end
      x
    end

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