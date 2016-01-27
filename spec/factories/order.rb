require 'faker'

FactoryGirl.define do
  factory :order do 
  	status "submitted"
  	user
  end
end