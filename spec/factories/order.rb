require 'faker'

FactoryGirl.define do
  factory :order do 
  	status "unsubmitted"
  	user
  end
end