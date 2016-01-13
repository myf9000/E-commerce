require 'rails_helper'

RSpec.describe Category, type: :model do

	it "has a valid category" do
    expect(build(:category)).to be_valid
  end

  it "has a valid category_child" do
    expect(build(:category, :category_child)).to be_valid
  end

  let(:category) { create(:category) }
  let(:category_child) { create(:category, :category_child) }

  describe "validations" do
  	# Basic validations
  	it { expect(category).to validate_presence_of(:name) }

  	# Inclusion/acceptance of values
  	it { expect(category).to validate_length_of(:name).is_at_least(2).is_at_most(20) }

  	# Format validations
  	it { expect(category).to_not allow_value("R<>%@?!").for(:name) }
  end

  describe "associations" do
  	it { expect(category).to have_many(:subcategories).class_name('Category').with_foreign_key('parent_id') }
  end

  describe "scopes" do # poprawic
  	context "#only_category" do
			it { expect(Category.only_category).to_not include category_child }
			it { expect(Category.only_category).to include category } #clean database??
		end
  end
end