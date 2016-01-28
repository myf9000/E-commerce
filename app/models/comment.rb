class Comment < ActiveRecord::Base
	belongs_to :user
	acts_as_tree order: 'created_at DESC'

	VALID_REGEX = /\A^[\w \.\-@:),.!?"']*$\Z/
	validates :body, presence: true, length: { in: 2..240}, format: { with: VALID_REGEX }

	def self.new_comment(params, user) 
		if params[:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:parent_id])
      comment = parent.children.build(params)
    else
      comment = user.comments.new(params)
    end
    comment.author_id = user.id
    comment.user_id = params[:user_id]
    comment
	end
end
