class Comment < ActiveRecord::Base
	belongs_to :user
	acts_as_tree order: 'created_at DESC'

	VALID_REGEX = /\A^[\w \.\-@:),.!?"']*$\Z/
  	validates :body, presence: true, length: { in: 2..240}, format: { with: VALID_REGEX }
end
