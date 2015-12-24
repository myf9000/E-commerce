class Category < ActiveRecord::Base
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category"

  scope :only_category, -> { where(:categories => {:parent_id => nil } ) }
end
