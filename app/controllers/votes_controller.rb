class VotesController < ApplicationController
  def new
  	@vote = current_user.votes.build
  end

  def create
  	@vote = current_user.votes.build(vote_params)
  	@vote.comentator_id = current_user.id
  	@vote.user_id = params[:id]
  	@user = User.find(@vote.user_id)
  	@user.active = false
  	@user.save
      if @vote.save
        redirect_to user_path(@vote.user_id), notice: 'Vote was successfully created.' 
      else
        render :new, notice: 'Vote was not successfully created.' 
      end
  end

  private

  def vote_params
  	params.require(:vote).permit(:comunication, :culture, :compatibility, :comment, :type_orders, :summary, :comentator_id)
  end
end
