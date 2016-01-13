require 'rails_helper'

RSpec.describe Rate, type: :model do
	
	describe "associations" do
		it { should belong_to(:rater) }
  	it { should belong_to(:rateable) }
	end
end