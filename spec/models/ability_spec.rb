# require "cancan/matchers"
# require 'spec_helper'

# describe "User" do
#   describe "product abilities" do
#   	let(:user){ nil }
#     subject(:ability){ Ability.new(user) }

#     context "when is an admin" do
#       let(:user){ FactoryGirl.create(:admin) }
#       it{ should be_able_to(:manage, FactoryGirl.create(:product, :user => user)) }
#     end
#   end
# end
