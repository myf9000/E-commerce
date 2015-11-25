module ProductsHelper
	def print_price(price)
		 number_to_currency price
	end

	def print_stock(stock, requested = 1)
		  lock = stock - requested
		  if lock == 0
		  	content_tag(:span, "Out of Stock", class: ["out_stock"])
		  elsif lock >= requested
		  	content_tag(:span, "In Stock (#{lock})", class: ["in_stock"])
		  elsif lock < requested + 3
		  	content_tag(:span, "Insufficient stock (#{lock})", class: "low_stock")
		  end
	end

end
