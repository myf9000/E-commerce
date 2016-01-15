require 'rails_helper'

RSpec.describe OrderItem, type: :model do

	it "has a valid order_item" do
    expect(build(:order_item)).to be_valid
  end

	let(:order_item) { FactoryGirl.build(:order_item) }

	describe "validations" do
		it { expect(order_item).to validate_presence_of(:order_id) }
		it { expect(order_item).to validate_presence_of(:product_id) }
		it { expect(order_item).to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
	end

	describe "associations" do
  	it { expect(order_item).to belong_to(:order) }
  	it { expect(order_item).to belong_to(:product) }
  end

  describe "instance methods" do
  	context "responds to its methods" do
  		it { expect(order_item).to respond_to(:subtotal) }
  		it { expect(order_item).to respond_to(:check_new_record) }
  	end

  	context "executes methods correctly" do
  		context "#subtotal" do
  			it { expect(order_item.subtotal(5,5)).to eq(25) }
  		end

  		context "#check_new_record" do
  			it { expect(order_item.check_new_record(order_item)).to eq(1) }
  		end
  	end
  end

  describe "model methods" do
  	context "responds to its methods" do
  		it { expect(OrderItem).to respond_to(:seller) } # User products 
  	end 
  end
end