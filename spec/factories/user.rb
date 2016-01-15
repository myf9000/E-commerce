FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password "12312312aa"
    password_confirmation { "12312312aa" }
    description {Faker::Lorem.sentence(3)}
  end

  factory :admin, :class => "User" do
    email {Faker::Internet.email}
    password "12312312aa"
    password_confirmation { "12312312aa" }
    description {Faker::Lorem.sentence(3)}
    admin true
  end
end