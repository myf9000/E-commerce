require 'faker'

FactoryGirl.define do
  factory :category do 
  	name { Faker::Lorem.word }
  end

  factory :category_child, :class => "Category" do 
  	name { Faker::Lorem.word }
  	parent_id 1
  end
end