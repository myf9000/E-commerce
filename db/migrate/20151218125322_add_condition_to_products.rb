class AddConditionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :con, :boolean, default: true
  end
end
