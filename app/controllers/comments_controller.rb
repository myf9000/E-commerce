class CommentsController < ApplicationController

  def create 
    @comment = Comment.new_comment(comment_params, current_user)
    if @comment.save
      redirect_to :back, notice: 'Your comment was successfully added!'
    else
      redirect_to :back, notice: @comment.errors.full_messages.join
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :parent_id, :user_id)
  end
end
