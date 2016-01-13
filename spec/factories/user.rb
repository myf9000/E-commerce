FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password "12312312aa"
    password_confirmation { "12312312aa" }
  end
end