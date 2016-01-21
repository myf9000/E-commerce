require "rails_helper"

describe ProductsHelper do
  describe "helper methods" do
	  context "#print_price" do
	    it { expect(helper.print_price(1)).to eq("$1.00") }
	  end

	  context "#print_stock zero" do
	    it { expect(helper.print_stock(0)).to eq("<span class=\"out_stock\">Out of Stock</span>") }
	  end

	  context "#print_stock more" do
	  	stock = 100
	    it { expect(helper.print_stock(stock)).to eq("<span class=\"in_stock\">#{stock}</span>") }
	  end

	  context "#print_stock more" do
	  	stock = 100
	    it { expect(helper.print_stock(stock, 101)).to eq("<span class=\"low_stock\">Insufficient stock (#{stock})</span>") }
	  end
	end
end