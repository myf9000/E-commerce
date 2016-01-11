require 'rails_helper'

RSpec.describe Info, type: :model do
	describe "belongs_to relationship with followable" do
  	it { should belong_to(:user) }
	end

  describe "validation attributes" do
  	let(:info) {FactoryGirl.create(:info)}

		it "is valid with correct attributes" do 
			expect(info).to be_valid
		end

		it "is invalid with uncorrect attributes" do 
			wrong_info = info
			wrong_info.city = "a" # min 2 characters
			expect(wrong_info).to_not be_valid
		end
	end
end