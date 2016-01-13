require 'faker'

FactoryGirl.define do
  factory :order do 
  	status { Faker::Lorem.word }
  	user
  end
end