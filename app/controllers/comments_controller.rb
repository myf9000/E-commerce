class CommentsController < ApplicationController

  def create 
    if params[:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
    else
      @comment = current_user.comments.new(comment_params)
    end
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to @comment.user, notice: 'Your comment was successfully added!'
    else
      redirect_to @comment.user, notice: @comment.errors.full_messages.join
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body, :author, :parent_id)
  end
end
