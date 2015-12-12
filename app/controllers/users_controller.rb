class UsersController < ApplicationController
  before_action :user_set

  def show
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

  def follow
    type = params[:type]
    if type == "unfollow"
      current_user.stop_following(@user)
      redirect_to user_path(current_user), notice: "You delete user from feed list"
      
    else
      current_user.follow(@user)
      redirect_to user_path(current_user), notice: "You add user from feed list"
    end
  end

  private

  def user_set
    @user = User.friendly.find(params[:id])
  end
  # ze statusami zamowienia pobawie sie pozniej 
end
