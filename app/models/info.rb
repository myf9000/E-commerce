class Info < ActiveRecord::Base
	belongs_to :user

 	VALID_REGEX = /\A^[\w \.\-]*$\Z/

  validates :city, :code, :last_name, :first_name, :street, presence: true, length: { in: 2..30}, format: { with: VALID_REGEX }
  validates :flat, :card_code, presence: true, numericality: true
  validates :user_id, presence: true
end
