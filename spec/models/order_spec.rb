require 'rails_helper'

RSpec.describe Order, type: :model do
	let(:order) { FactoryGirl.create(:order) }

	describe "belongs_to user" do
  	it { should belong_to(:user) }
	end

	describe "have_many order_items" do
  	it { should have_many(:order_items) }
	end

  describe "validation attr user_id & status" do
		it "is valid with user_id" do 
			expect(order).to be_valid
		end

		it "is invalid without user_id & status" do 
			wrong_order = Order.new
			expect(wrong_order).to_not be_valid
		end
	end

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