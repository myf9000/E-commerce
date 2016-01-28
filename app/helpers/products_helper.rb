module ProductsHelper
	def print_price(price)
		number_to_currency price
	end

	def print_stock(stock, requested = 1)
	  if stock == 0
	  	content_tag(:span, "Out of Stock", class: ["out_stock"])
	  elsif stock >= requested
	  	content_tag(:span, "#{stock}", class: ["in_stock"])
	  elsif stock < requested + (stock * 0.1).to_i
	  	content_tag(:span, "Insufficient stock (#{stock})", class: "low_stock")
	  end
	end

	def options_for_company
		[ "Apple", "Microsoft", "IBM", "Adidas", "Ford", "Mercedes", "HTC", "SONY", "other", "Nike" ]
	end

end
