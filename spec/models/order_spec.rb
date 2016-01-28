require 'rails_helper'

RSpec.describe Order, type: :model do

	it "has a valid order" do
    expect(build(:order)).to be_valid
  end


	let(:order) { build(:order) }

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
  		it { expect(order).to respond_to(:buyed) }
  		it { expect(order).to respond_to(:set_status) }
  	end

  	context "executes methods correctly" do
  		before do
  			u = create(:user)
				p = create(:product, :user => u, stock: 100, price: 1)

				@o =  create(:order, :user => u)
				@oi = create(:order_item, :product => p, :order => @o, quantity: 50)

				@o2 =  create(:order, :user => u)
				@oi2 = create(:order_item, :product => p, :order => @o2, quantity: 150)
  		end

			context "#total" do
				it "total should be 50" do
					expect(@o.total).to eq(50)
				end
			end

			context "#check_in" do
				it "check_in should be true" do
					expect(@o.check_in).to eq(true)
				end

				it "check_in should not be true" do
					expect(@o2.check_in).to eq(false)
				end
			end

			context "#buyed" do
				context "it is valid" do
					it "should change quantity of product" do
						@o.buyed
						@oi.reload
						expect(@oi.product.stock).to eq(50)
					end

					it "should set status to submitted" do
						@o.buyed
						expect(@o.status).to eq("submitted")
					end
				end

				context "it is invalid" do
					it "should not change quantity of product" do
						@o2.buyed
						@oi2.reload
						expect(@oi2.product.stock).to eq(100)
					end

					it "should not set status to submitted" do
						@o2.buyed
						expect(@o.status).to_not eq("submitted")
					end
				end
			end

			context "#set_status" do
				it "status should be the same" do
					order.set_status("lala")
					expect(order.status).to eq("lala")
				end
			end
		end
	end
end