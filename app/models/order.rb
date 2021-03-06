class Order < ActiveRecord::Base
	has_many :order_items, dependent: :destroy
	belongs_to :user

 	validates :user_id, :status, presence: true

	def total
	  t = 0
	    order_items.each do |f|
	      t += f.subtotal(f.quantity, f.product.price)
		end
		t
	end

	def check_in
    x = true
    order_items.each do |f|
      check = f.product.stock - f.quantity
      if check < 0
        x = false
      end
    end
    x
  end
 
  def buyed
  	order_items.each do |f|
      check = f.product.stock - f.quantity
      f.product.active = false if check == 0
      f.product.stock = check
      f.product.save
    end
    self.status = "submitted"
    self.save
  end

  def set_status(status)
  	self.status = status
    self.save
  end
end
