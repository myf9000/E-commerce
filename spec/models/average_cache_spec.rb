require 'rails_helper'

RSpec.describe AverageCache, type: :model do
	describe "belongs_to relationship with rater" do
  	it { should belong_to(:rater) }
	end

	describe "belongs_to relationship with rateable" do
  	it { should belong_to(:rateable) }
	end
end