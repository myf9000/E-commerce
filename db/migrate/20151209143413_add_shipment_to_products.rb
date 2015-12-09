class AddShipmentToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shipment, :text
  end
end
