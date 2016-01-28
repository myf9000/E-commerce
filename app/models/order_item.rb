class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product

	validates :order_id, :product_id, presence: :true
	validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  def subtotal(quantity, price)
    quantity * price  
  end
  
  def check_new_record
  	self.new_record? ? self.quantity = 1 : self.quantity += 1
  end

  def is_ok?(current_user)
    current_user != self.product.user && self.quantity <= self.product.stock
  end

  def self.seller(sell)
  	list = Array.new
	  self.all.each do |o|
      sell.each do |i|
        if o.product_id == i 
          list << o
        end
      end
	  end
	  list
	end
end
