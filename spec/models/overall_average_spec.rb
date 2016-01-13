require 'rails_helper'

RSpec.describe AverageCache, type: :model do
	
	describe "associations" do
  	it { should belong_to(:rateable) }
	end
end