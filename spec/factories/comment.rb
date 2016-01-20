require 'faker'

FactoryGirl.define do
	factory :comment do 
  	body { Faker::App.name }
    parent_id nil
  	user
  end

  factory :comment_child, :class => "Comment" do 
  	body { Faker::App.name }
  	parent_id 1
  	user
  end

  factory :invalid_comment, :class => "Comment" do 
  	body nil
  	user
  end
end
