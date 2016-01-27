class UsersController < ApplicationController
  before_action :user_set

  def show
    @comments = @user.comments.hash_tree
    @comment = @user.comments.build(parent_id: params[:parent_id])
  	@seller_items = @user.seller_list
  end

  def follow
    if params[:type].to_s == "unfollow"
      current_user.stop_following(@user)
      redirect_to current_user, alert: "You delete user from feed list"
    else
      current_user.follow(@user)
      redirect_to current_user, notice: "You add user to feed list"
    end
  end

  private

    def user_set
      @user = User.friendly.find(params[:id])
    end
  
end
 