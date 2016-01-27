require 'faker'

FactoryGirl.define do
  factory :product do 
    title       { Faker::Hacker.noun }
    price       { Faker::Commerce.price }
    description { Faker::Hacker.noun }
    stock       1
    active      true
    category    1
    subcategory 2
    company     { Faker::Hacker.noun }
    technical   { Faker::Hacker.noun }
    shipment    { Faker::Hacker.noun }
    con         true
    user
  end

  factory :invalid_product, parent: :product do 
    title nil
  end
end