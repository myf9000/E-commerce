require 'rails_helper'

RSpec.describe OrderItem, type: :model do
	let(:order_item) { FactoryGirl.create(:order_item) }

	describe "belongs_to order" do
  	it { should belong_to(:order) }
	end

	describe "belongs_to product" do
  	it { should belong_to(:product) }
	end

  describe "validation attr order_id, product_id and quantity" do
		it "is valid with user_id" do 
			expect(order_item).to be_valid
		end

		it "is invalid without user_id & status" do 
			wrong_order_item = OrderItem.new
			expect(wrong_order_item).to_not be_valid
		end

		it "quantity is a number" do
			expect(order_item.quantity.class).to eq(1.class)
		end
	end
end