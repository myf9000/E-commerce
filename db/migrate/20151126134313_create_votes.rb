class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :comunication
      t.integer :culture
      t.integer :compatibility
      t.text :comment
      t.string :type_orders
      t.string :summary

      t.timestamps null: false
    end
  end
end
