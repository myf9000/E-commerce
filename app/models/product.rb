class Product < ActiveRecord::Base
	validates_numericality_of :price
	validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	has_many :order_items
	belongs_to :user

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://res.freestockphotos.biz/pictures/9/9552-a-green-apple-on-a-dark-background-pv.jpg"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	extend FriendlyId
  	friendly_id :title, use: :slugged

  	is_impressionable

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
