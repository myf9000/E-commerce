require 'rails_helper'

RSpec.describe Comment, type: :model do
	describe "#validation attr body" do 
		it "is valid with body" do 
			comment = Comment.new(body: "Rails")
			expect(comment).to be_valid
		end

		it "is invalid without body" do 
			comment = Comment.new()
			expect(comment).to_not be_valid
		end

		it "is valid with body which has 2 characters" do 
			comment = Comment.new(body: "Ra")
			expect(comment).to be_valid
		end

		it "is invalid with body which has not 2 characters" do 
			comment = Comment.new(body: "R")
			expect(comment).to_not be_valid
		end

		it "is invalid with body which has 241 characters" do 
			body = "R" * 241
			comment = Comment.new(body: body)
			expect(comment).to_not be_valid
		end

		it "is invalid with wrong REGEX" do
			body = "R<>!?"
			comment = Comment.new(body: body)
			expect(comment).to_not be_valid
		end
	end

	describe "belongs_to relationship with user" do
  	it { should belong_to(:user) }
	end

	describe "#acts as tree model" do
		it "child should has parent_id" do
			parent = FactoryGirl.create(:comment)
			child = FactoryGirl.create(:comment, :parent_id => parent.id)
			expect(child.parent_id).to eq(parent.id)
		end
	end

end 