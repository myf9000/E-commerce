require 'faker'

FactoryGirl.define do
  factory :product do 
    title       { Faker::Hacker.noun }
    price       { Faker::Commerce.price }
    description { Faker::Hacker.noun }
    stock       1
    active      true
    category    { Faker::Hacker.noun }
    subcategory { Faker::Hacker.noun }
    company     { Faker::Hacker.noun }
    technical   { Faker::Hacker.noun }
    shipment    { Faker::Hacker.noun }
    con         true
    user
  end
end