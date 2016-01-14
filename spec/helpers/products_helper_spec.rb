require "rails_helper"

# module ProductsHelper
# 	def print_price(price)
# 		 number_to_currency price
# 	end

# 	def print_stock(stock, requested = 1)
# 		  if stock == 0
# 		  	content_tag(:span, "Out of Stock", class: ["out_stock"])
# 		  elsif stock >= requested
# 		  	content_tag(:span, "#{stock}", class: ["in_stock"])
# 		  elsif stock < requested + (stock * 0.1).to_i
# 		  	content_tag(:span, "Insufficient stock (#{stock})", class: "low_stock")
# 		  end
# 	end

# end


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