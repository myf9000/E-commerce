class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product

	validates :order_id, :product_id, presence: :true
	validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  def subtotal(quantity, price)
    quantity * price
  end
  
  def check_new_record(order)
  	order.new_record? ? order.quantity = 1 : order.quantity += 1
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
