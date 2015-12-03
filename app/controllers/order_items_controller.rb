class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:edit, :update, :destroy]
  before_action :load_order, only: [:create, :update, :buy]


  # GET /order_items
  # GET /order_items.json
  
  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    # w create tworzymy nowa instancje, a albo szukamy utworzonej 

      @order_item = @order.order_items.find_by(product_id: params[:product_id])|| @order.order_items.new(quantity: 1, product_id: params[:product_id])
      if @order_item.new_record?
        @order_item.quantity = 1
      else 
         @order_item.quantity += 1
      end

    if current_user.id != Product.find(@order_item.product_id).user_id
      check_in = @order_item.product.stock - @order_item.quantity
      respond_to do |format|
        if check_in > -1 && @order_item.save
          format.html { redirect_to @order, notice: 'Order item was successfully created.' }
          format.json { render :show, status: :created, location: @order_item }
        else
          format.html { render :new, notice: 'Order item was not created.'  }
          format.json { render json: @order_item.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back , notice: 'You can not buy your product' 
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
      check_in = @order_item.product.stock - @order_item.quantity
      if params[:order_item][:quantity].to_i == 0
        @order_item.destroy
        redirect_to @order, notice: 'Order item was successfully destroyed.'
      elsif check_in > -1 && @order_item.update(order_item_params)
        redirect_to @order, notice: 'Order item was successfully updated.'
      else
        render :edit, notice: 'Order item was not updated.' 
      end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

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
    # Use callbacks to share common setup or constraints between actions.
    def load_order
    @order = Order.find_by(id: session[:order_id], status: "unsubmitted") || current_user.orders.build(status: "unsubmitted")
    if @order.new_record?
      #@order.user_id = current_user.id
      @order.save!
      session[:order_id] = @order.id
    end
  end

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id, :quantity)
    end
end
