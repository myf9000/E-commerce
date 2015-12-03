class Product < ActiveRecord::Base
	validates_numericality_of :price
	validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	has_many :order_items
	belongs_to :user

	extend FriendlyId
  	friendly_id :title, use: :slugged

	def price=(input)
  		input.delete!("$")
  		super
	end

	def quantites_total
	  q = 0
	    order_items.each do |f|
	      q += f.quantity
		end
		q
	end
end
