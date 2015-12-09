class AddTechnicalToProducts < ActiveRecord::Migration
  def change
    add_column :products, :technical, :text
  end
end
