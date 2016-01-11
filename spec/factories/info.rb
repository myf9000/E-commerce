require 'faker'

FactoryGirl.define do
  factory :info do 
  	city { Faker::Address.city }
  	code { Faker::Address.zip }
  	last_name { Faker::Name.last_name }
  	first_name { Faker::Name.first_name }
  	street { Faker::Address.street_name }
  	flat 1
  	card_code 1
  	user_id 1
  end
end