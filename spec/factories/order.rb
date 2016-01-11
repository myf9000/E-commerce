require 'faker'

FactoryGirl.define do
  factory :order do 
  	status { Faker::Lorem.word }
  	user_id 1
  end
end