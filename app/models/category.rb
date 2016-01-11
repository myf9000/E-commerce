class Category < ActiveRecord::Base
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category"

  VALID_REGEX = /\A^[\w \.\-@]*$\Z/
  validates :name, presence: true, length: { in: 2..20}, format: { with: VALID_REGEX }

  scope :only_category, -> { where(:categories => {:parent_id => nil } ) }
end
 