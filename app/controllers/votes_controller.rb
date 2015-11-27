class VotesController < ApplicationController
  before_action :check_pair
  def new
  	@vote = current_user.votes.build
  end

  def create
  	@vote = current_user.votes.build(vote_params)
  	@vote.comentator_id = current_user.id
  	@vote.user_id = params[:id]
  	@user = User.find(@vote.user_id)
  	@user.active = true
  	@user.save
      if @vote.save
        redirect_to user_path(@vote.user_id), notice: 'Vote was successfully created.' 
      else
        render :new, notice: 'Vote was not successfully created.' 
      end
  end

  def check_pair
    pair_one = false
    pair_two = false

    pair_one = true if (Product.find_by_user_id(current_user.id).present? || Order.find_by_user_id(current_user.id).present?)
    pair_two = true if (Product.find_by_user_id(current_user.id).present? || Order.find_by_user_id(current_user.id).present?)

    if !(pair_one && pair_two)
      redirect_to products_path, notice: "You cannot vote for this user!"
    end
  end


  private

  def vote_params
  	params.require(:vote).permit(:comunication, :culture, :compatibility, :comment, :type_orders, :summary, :comentator_id)
  end
end
