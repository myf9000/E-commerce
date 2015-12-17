class CommentsController < ApplicationController


  def create 
    if params[:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end
    @comment.author_id = current_user.id
    if @comment.save
      if @comment.parent == nil
        redirect_to :back, notice: 'Your comment was successfully added!'
      else  
        redirect_to user_path(Comment.find(@comment.parent).user_id), notice: 'Your comment was successfully added!'
      end
    else
      render 'new'
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :author, :parent_id)
  end
end
