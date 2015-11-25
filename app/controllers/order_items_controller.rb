class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:edit, :update, :destroy]
  before_action :load_order, only: [:create, :update]


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

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_order
    @order = Order.find_by(id: session[:order_id], status: "unsubmitted") || current_user.orders.build(id: session[:order_id], status: "unsubmitted")
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