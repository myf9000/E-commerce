class Order < ActiveRecord::Base
	has_many :order_items, dependent: :destroy
	belongs_to :user

	def total
	  t = 0
	    order_items.each do |f|
	      t += f.subtotal(f.quantity, f.product.price)
		end
		t
	end


end
