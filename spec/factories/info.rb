
FactoryGirl.define do
  factory :info do 
  	city "Wroclaw"
  	code 12345
  	last_name "Rails"
  	first_name "Ruby"
  	street "Ruby on Rails"
  	flat 1
  	card_code 1
  	user
  end

  factory :invalid_info, parent: :info do 
    first_name nil
  end
end