require 'rails_helper'

RSpec.describe Category, type: :model do
	describe "has_many relationship with subcategories" do
  	it { should have_many(:subcategories).class_name('Category').with_foreign_key('parent_id') }
	end

	describe "validation attr name" do
		it "is valid with name" do 
			category = Category.new(name: "Rails")
			expect(category).to be_valid
		end

		it "is invalid without name" do 
			category = Category.new()
			expect(category).to_not be_valid
		end

		it "is valid with name which has 2 characters" do 
			category = Category.new(name: "Ra")
			expect(category).to be_valid
		end

		it "is invalid with name which has not 2 characters" do 
			category = Category.new(name: "R")
			expect(category).to_not be_valid
		end

		it "is invalid with name which has 21 characters" do 
			name = "R" * 21
			category = Category.new(name: name)
			expect(category).to_not be_valid
		end

		it "is invalid with name has wrong REGEX" do
			name = "R<>!?"
			category = Category.new(name: name)
			expect(category).to_not be_valid
		end
	end

	describe "#only_category scopes" do
		let(:category) {FactoryGirl.create(:category)}
		let(:category_child) { FactoryGirl.create(:category_child) }

		it "not include category with parent_id" do
			expect(Category.only_category).to_not include category_child
		end

		it "include category without parent_id" do
			expect(Category.only_category).to include category
		end
	end
end