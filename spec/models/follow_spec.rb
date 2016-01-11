require 'rails_helper'

RSpec.describe Follow, type: :model do
	describe "belongs_to relationship with followable" do
  		it { should belong_to(:followable) }
	end

	describe "belongs_to relationship with follower" do
  		it { should belong_to(:follower) }
	end

end