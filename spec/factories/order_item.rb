require 'faker'

FactoryGirl.define do
  factory :order_item do 
  	quantity 1
  	product
  	order
  end
end