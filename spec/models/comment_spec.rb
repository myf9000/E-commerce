require 'rails_helper'

RSpec.describe Comment, type: :model do

	it "has a valid comment" do
    expect(build(:comment)).to be_valid
  end

  it "has a valid comment_child" do
    expect(build(:comment_child)).to be_valid
  end

  let(:comment) { FactoryGirl.build(:comment) }
  let(:comment_child) { FactoryGirl.build(:comment_child, :parent_id => comment.id) }

  describe "validations" do
  	# Basic validations
  	it { expect(comment).to validate_presence_of(:body) }

  	# Inclusion/acceptance of values
  	it { expect(comment).to validate_length_of(:body).is_at_least(2).is_at_most(240) }

  	# Format validations
  	it { expect(comment).to_not allow_value("R<>%@?!").for(:body) }
  end

  describe "associations" do
  	it { expect(comment).to belong_to(:user) }
  end

	describe ".acts as tree" do
		it "child should has parent_id" do
			expect(comment_child.parent_id).to eq(comment.id)
		end
	end

end 