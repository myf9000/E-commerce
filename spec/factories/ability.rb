require 'faker'

FactoryGirl.define do

  factory :admin, :class => "User" do |f|                 
    f.email { Faker::Internet.email }
    f.password "secret"
    f.admin true
  end
  
  
end