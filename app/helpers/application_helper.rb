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

  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-success"
      when :info then "alert alert-info"
      when :alert then "alert alert-danger"
      when :warning then "alert alert-warning"
    end
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end
end
