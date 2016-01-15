require "cancan/matchers"
require 'rails_helper'

RSpec.describe Ability, type: :model do
	it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "has a valid factory" do
    expect(build(:admin)).to be_valid
  end

	let(:user)  { create(:user)}
	let(:user2) { create(:user)}
	let(:admin) { create(:admin)}

	let(:ability_user)  { Ability.new(user) }
	let(:ability_user2) { Ability.new(user2) }
	let(:ability_admin) { Ability.new(admin) }

	describe "#initialize" do
		context "product" do
		  before do
		  	@product = create(:product, :user=> user)
		  end

		  it "when is admin" do
		    expect(ability_admin).to be_able_to(:manage, @product)
		  end

		  it "when is product user" do
		    expect(ability_user).to be_able_to(:manage, @product)
		  end

		  it "when is other user" do
		    expect(ability_user2).to_not be_able_to(:manage, @product)
		  end
		end

		context "order" do
		  before do
		  	@order = create(:order, :user=> user)
		  end

		  it "when is admin" do
		    expect(ability_admin).to be_able_to(:manage, @order)
		  end

		  it "when is order user" do
		    expect(ability_user).to be_able_to(:manage, @order)
		  end

		  it "when is other user" do
		    expect(ability_user2).to_not be_able_to(:manage, @order)
		  end
		end


	end
end
