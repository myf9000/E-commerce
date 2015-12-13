class CommentsController < ApplicationController
  def new  
  	@comment = Comment.new(parent_id: params[:parent_id], user_id: params[:user_id], author_id: params[:author_id]) 
  	@comment.author_id = current_user.id
  	@comment.user_id = Comment.find(params[:parent_id]).user_id

  	render layout: "layout_for_form" 
  end

  def create 
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to :back, notice: 'Your comment was successfully added!'
    else
      render 'new'
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :author, :parent_id)
  end
end
