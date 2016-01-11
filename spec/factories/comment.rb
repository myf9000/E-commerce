require 'faker'

FactoryGirl.define do
	factory :comment do 
  	body { Faker::Lorem.word }
  	user_id 1
  end
end