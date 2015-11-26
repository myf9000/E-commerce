class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])

  	arr = Array.new
  	@user.products.each do |f|
  		arr << f.id
  	end

  	order_items = OrderItem.all
  	@brr = Array.new
  	order_items.each do |o|
	  	arr.each do |i|
	  	  if o.product_id == i
	  		@brr << o
	  	  end
  		end
  	end
  end
end
