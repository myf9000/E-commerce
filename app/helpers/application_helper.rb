module ApplicationHelper
	def check_stock(stock, requested = 0)
		check = false
		lock = stock - requested
		  if lock > 0
		  	check = true
		  else
		  	check = false
		  end
		check
	end
end
