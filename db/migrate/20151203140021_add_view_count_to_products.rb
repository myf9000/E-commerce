class AddViewCountToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :viewed_count, :integer, default: 0
  end
end
