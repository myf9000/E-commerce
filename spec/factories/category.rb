require 'faker'

FactoryGirl.define do
  factory :category do 
  	name { Faker::App.name }

	  trait :category_child do
	  	name { Faker::App.name }
	  	parent_id 1
	  end
	end

	factory :invalid_category, parent: :category do 
  	name nil
	end
end