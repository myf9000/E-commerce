require 'faker'

FactoryGirl.define do

  factory :admin, :class => "User" do |f|                 
    f.email { Faker::Internet.email }
    f.password "secret"
    f.admin true
  end

  factory :user, :class => "User" do |f|                        
    f.email { Faker::Internet.email }
    f.password "secret"
  end
  
  factory :product, :class => "Product" do |f|                        
    f.title { Faker::Commerce.product_name }
    f.price { Faker::Commerce.price }
    f.description { Faker::Commerce.product_name }
    f.stock 5
    f.active true
    f.category "Motoryzacja"
    f.subcategory "Opony"
    f.company "IBM"
    f.con true
    f.technical { Faker::Commerce.product_name }
    f.shipment { Faker::Commerce.product_name }
  end

end