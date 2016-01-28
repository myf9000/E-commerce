require 'rails_helper'

RSpec.describe Product, type: :model do
	it "has a valid factory" do
    expect(build(:product)).to be_valid
  end

  let(:product) { build(:product) }
 
  describe "validations" do
  	# Basic validations
  	it { expect(product).to validate_presence_of(:title) }
  	it { expect(product).to validate_presence_of(:description) }
  	it { expect(product).to validate_presence_of(:technical) }
  	it { expect(product).to validate_presence_of(:shipment) }
  	it { expect(product).to validate_presence_of(:price) }
  	it { expect(product).to validate_presence_of(:stock) }
  	it { expect(product).to validate_presence_of(:user_id) }
  	it { expect(product).to validate_presence_of(:category) }
  	it { expect(product).to validate_presence_of(:subcategory) }
  	it { expect(product).to validate_presence_of(:company) }

  	# Length validations
  	it { expect(product).to validate_length_of(:title).is_at_least(2).is_at_most(30) }
  	it { expect(product).to validate_length_of(:description).is_at_least(2).is_at_most(500) }
  	it { expect(product).to validate_length_of(:technical).is_at_least(2).is_at_most(500) }
  	it { expect(product).to validate_length_of(:shipment).is_at_least(2).is_at_most(500) }

  	# Format validations
  	invalid_regex = "R<>%@?!"
  	it { expect(product).to_not allow_value(invalid_regex).for(:title) }
  	it { expect(product).to_not allow_value(invalid_regex).for(:description) }
  	it { expect(product).to_not allow_value(invalid_regex).for(:technical) }
  	it { expect(product).to_not allow_value(invalid_regex).for(:shipment) }

  	# Numericality validations
  	it { expect(product).to validate_numericality_of(:price) }
  	it { expect(product).to validate_numericality_of(:stock).only_integer.is_greater_than_or_equal_to(0) }

  	# Allow blank validations
  	it { expect(product).to allow_value("", nil).for(:con) }
  	it { expect(product).to allow_value("", nil).for(:active) }

  	# Inclusion validations
  	#it { expect(product).to validate_inclusion_of(:con).in_array([true, false]) }
  	#it { expect(product).to validate_inclusion_of(:active).in_array([true, false]) }

  	# Avatar validations
  	it { expect(product).to have_attached_file(:avatar) }
	  it { expect(product).to validate_attachment_content_type(:avatar).allowing('image/png', 'image/gif').rejecting('text/plain', 'text/xml') }
  end

  describe "associations" do
  	it { expect(product).to belong_to(:user) }
  	it { expect(product).to have_many(:order_items) }
  	it { expect(product).to have_many(:pictures).dependent(:destroy) }
  	it { expect(product).to accept_nested_attributes_for(:pictures) }
  end

  describe "scopes" do
  	context ".title_like" do 
  		it { expect(Product.title_like(product.title)).to eq(Product.where("title like ?", product.title)) }
  	end
  end

  describe "class methods" do
		context "responds to its methods" do
  		it { expect(Product).to respond_to(:ordered_by) }
  		it { expect(Product).to respond_to(:shows) }
      it { expect(Product).to respond_to(:find_products) }
  	end

  	context "executes methods correctly" do
  		context ".ordered_by" do
  			it { expect(Product.ordered_by("DESC")).to eq(Product.all.order("created_at DESC")) }
  		end

  		context ".shows" do
  			before do
  				@p  = create(:product, company: "IBM", subcategory: "Tablet")
					@p2 = create(:product, company: "IBM", subcategory: "Proccessor")
					@p3 = create(:product, company: "Apple", subcategory: "Tablet")
  			end

  			it { expect(Product.shows("company", @p.company)).to include @p }
  			it { expect(Product.shows("company", @p.company)).to include @p2 }
  			it { expect(Product.shows("company", @p.company)).to_not include @p3 }

  			it { expect(Product.shows("subcategory", @p.subcategory)).to include @p }
  			it { expect(Product.shows("subcategory", @p.subcategory)).to include @p3 }
  			it { expect(Product.shows("subcategory", @p.subcategory)).to_not include @p2 }
  		end
  	end
  end

  describe "instance methods" do
		context "responds to its methods" do
  		it { expect(product).to respond_to(:quantites_total) }
  		it { expect(product).to respond_to(:related) }
  	end

  	context "executes methods correctly" do
  		context "#quantites_total" do
  			it "it should be 0" do
  				p = create(:product, company: "IBM", subcategory: "Tablet")
  				expect(p.quantites_total).to eq(0)
  			end

  			it "it should be 5" do
  				p = create(:product, company: "IBM", subcategory: "Tablet")
  				u = create(:user)
  				o = create(:order, :user => u)
  				oi = create(:order_item, :product => p, :order => o, :quantity => 5)
  				expect(p.quantites_total).to eq(5)
  			end
  		end

  		context "#related" do
  			before do
  				@p  = create(:product, company: "IBM", subcategory: "Tablet")
					@p2 = create(:product, company: "IBM", subcategory: "Proccessor")
					@p3 = create(:product, company: "Apple", subcategory: "Tablet")
  			end

  			it { expect(@p.related).to_not include @p }
  			it { expect(@p.related).to_not include @p2 }
  			it { expect(@p.related).to include @p3 }
  		end
  	end
  end
end
