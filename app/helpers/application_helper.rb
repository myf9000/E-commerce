module ApplicationHelper

	def check_stock(stock, requested = 0)
		check = false
		lock = stock - requested
		  if lock >= 0
		  	check = true
		  elsif stock > 0
		  	check = true
		  else
		  	check = false
		  end
		requested = 0
		check
	end
end
