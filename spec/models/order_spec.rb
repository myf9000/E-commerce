require 'rails_helper'

RSpec.describe Order, type: :model do

	it "has a valid order" do
    expect(build(:order)).to be_valid
  end

	let(:order) { FactoryGirl.build(:order) }

	describe "validations" do
		it { expect(order).to validate_presence_of(:user_id) }
		it { expect(order).to validate_presence_of(:status) }
	end

	describe "associations" do
  	it { expect(order).to belong_to(:user) }
  	it { expect(order).to have_many(:order_items).dependent(:destroy)  }
  end

	describe "instance methods" do
		context "responds to its methods" do
  		it { expect(order).to respond_to(:total) }
  		it { expect(order).to respond_to(:check_in) }
  	end

  	context "executes methods correctly" do
			context "#total" do
				it "total should be 0" do
					expect(order.total).to eq(0)
				end
			end

			context "#check_in" do
				it "check_in should be true" do
					expect(order.check_in).to eq(true)
				end
			end
		end
	end
end