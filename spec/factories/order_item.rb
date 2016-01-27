require 'faker'

FactoryGirl.define do
  factory :order_item do 
  	quantity 10
  	product
  	order
  end

  factory :invalid_order_item, parent: :order_item do 
    quantity "lalal"
  end

  factory :order_item_zero, parent: :order_item do 
    quantity 0
    product
    order
  end
end