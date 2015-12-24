module ApplicationHelper

	def check_stock(stock)
		stock > 0 ? true : false
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

  def set_title_of_page(page_title="")
		add = "Shopper"
		if page_title.empty?
			page_title = add
		else
			page_title = page_title+ " | " +add
		end
  end
end
