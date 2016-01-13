require 'rails_helper'


RSpec.describe Info, type: :model do

	it "has a valid info" do
    expect(build(:info)).to be_valid
  end

  let(:info) { FactoryGirl.build(:info) }

  describe "validations" do
  	# Basic validations
  	it { expect(info).to validate_presence_of(:city) }
  	it { expect(info).to validate_presence_of(:code) }
  	it { expect(info).to validate_presence_of(:last_name) }
  	it { expect(info).to validate_presence_of(:first_name) }
  	it { expect(info).to validate_presence_of(:street) }
  	it { expect(info).to validate_presence_of(:flat) }
  	it { expect(info).to validate_presence_of(:card_code) }
  	it { expect(info).to validate_presence_of(:user_id) }

  	# Inclusion/acceptance of values
  	it { expect(info).to validate_length_of(:city).is_at_least(2).is_at_most(30) }
  	it { expect(info).to validate_length_of(:code).is_at_least(2).is_at_most(30) }
  	it { expect(info).to validate_length_of(:last_name).is_at_least(2).is_at_most(30) }
  	it { expect(info).to validate_length_of(:first_name).is_at_least(2).is_at_most(30) }
  	it { expect(info).to validate_length_of(:street).is_at_least(2).is_at_most(30) }
  	it { expect(info).to validate_numericality_of(:flat) }
  	it { expect(info).to validate_numericality_of(:card_code) }

  	# Format validations
  	invalid_regex = "R<>%@?!"
  	it { expect(info).to_not allow_value(invalid_regex).for(:city) }
  	it { expect(info).to_not allow_value(invalid_regex).for(:code) }
  	it { expect(info).to_not allow_value(invalid_regex).for(:last_name) }
  	it { expect(info).to_not allow_value(invalid_regex).for(:first_name) }
  	it { expect(info).to_not allow_value(invalid_regex).for(:street) }
  end

	describe "associations" do
  	it { expect(info).to belong_to(:user) }
  end
  
end