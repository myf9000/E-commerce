require 'rails_helper'

RSpec.describe User, type: :model do

	it "has a valid order" do
    expect(build(:user)).to be_valid
  end

	let(:user) { create(:user) }

	describe "validations" do
		it { expect(user).to validate_length_of(:description).is_at_least(2).is_at_most(200) }
		it { expect(user).to allow_value("", nil).for(:description) }
		it { expect(user).to_not allow_value("<>%$P#?!*/").for(:description) }

		it { expect(user).to have_attached_file(:avatar) }
	  it { expect(user).to validate_attachment_content_type(:avatar).allowing('image/png', 'image/gif').rejecting('text/plain', 'text/xml') }
	end

	describe "associations" do
  	it { expect(user).to have_many(:orders).dependent(:destroy) }
  	it { expect(user).to have_many(:products).dependent(:destroy) }
  	it { expect(user).to have_many(:comments).dependent(:destroy) }
  	it { expect(user).to have_one(:info).dependent(:destroy) }
  end

	describe "instance methods" do
		context "responds to its methods" do
  		it { expect(user).to respond_to(:mailboxer_email) }
  		it { expect(user).to respond_to(:user_score) }
  	end

  	context "executes methods correctly" do
			context "#mailboxer_email" do
				it "email" do
  		    user.email = "jaja@jaja.pl"
					expect(user.mailboxer_email(user)).to eq("jaja@jaja.pl")
				end
			end
		end
	end

	describe "model methods" do
		context "responds to its methods" do
  		it { expect(User).to respond_to(:seller_list) }
  	end

  	context "executes methods correctly" do
  		before do
  			u2 = create(:user)
  			
				@p = create(:product, :user => user)
				@p2 = create(:product, :user => user)

				o =  create(:order, :user => u2)
				oi = create(:order_item, :product => @p, :order => o)
  		end

			context ".seller_list" do
				it "include sells product" do
					expect(User.seller_list(user).last.product_id).to eq(@p.id)
				end

				it "does not include other product" do
					expect(User.seller_list(user).last.product_id).to_not eq(@p2.id)
				end
			end
		end
	end
end