class Picture < ActiveRecord::Base
	has_attached_file :pict, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :pict, content_type: /\Aimage\/.*\Z/

  	belongs_to :product
end
