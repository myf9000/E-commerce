class Product < ActiveRecord::Base
	has_many :order_items
	belongs_to :user
	has_many :pictures, dependent: :destroy

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "back.jpg"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	accepts_nested_attributes_for :pictures, reject_if: proc { |attributes| attributes['pict'].blank? }, allow_destroy: true

  VALID_REGEX = /\A^[\w \.\-@:),.!?"']*$\Z/
	validates :title, presence: true, length: { in: 2..30}, format: { with: VALID_REGEX }
	validates :description, :technical, :shipment, presence: true, length: { in: 2..500}, format: { with: VALID_REGEX }
	validates :price, presence: true, numericality: true
	validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :user_id, :category, :subcategory, :company, presence: true
	validates :active, :con, allow_blank: true,:inclusion => {:in => [true, false]}

	scope :title_like, -> (title) { where("title like ?", title)}

	extend FriendlyId
	friendly_id :title, use: :slugged
	is_impressionable #:counter_cache => true, :column_name => :viewed_count, :uniq => true

	def self.ordered_by(param)
	    case param
		    when 'DESC'     then 	Product.all.order("created_at DESC")
		    when 'ASC'		 	then 	Product.all.order("created_at ASC")
		    when 'small'		then 	Product.all.order("price ASC")
		    when 'big'			then 	Product.all.order("price DESC")
		    when 'top'			then 	Product.all.order("viewed_count ASC")
		    else                  Product.all
		end
  end

  def self.shows(what, compare)
  	case what
	    when 'price'     	then 	Product.all.select {|f| if f.price <= compare.to_i; f; end  };
	    when 'company'		then 	Product.all.select {|f| if f.company == compare; f; end  };
	    when 'category'		then 	Product.all.select {|f| if f.category == compare; f; end };
	    when 'subcategory'then 	Product.all.select {|f| if f.subcategory == compare; f; end };
	    else                  	Product.all
		end
	end

	# def price=(input)
	# 	input.delete!("$")
	# 	super
	# end

	def quantites_total
	  q = 0
	    order_items.each do |f|
	      q += f.quantity
		end
		q
	end

	def related
		products = Product.all.select {|i| i.subcategory == self.subcategory and i.id != self.id}
		products = products[0..20]
	end
end
