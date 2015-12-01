class AddVariableToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category, :string
    add_column :products, :subcategory, :string
  end
end
