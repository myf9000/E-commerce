class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :city
      t.string :code
      t.integer :flat
      t.string :street
      t.string :first_name
      t.string :last_name
      t.integer :user_id
      t.integer :card_code

      t.timestamps null: false
    end
    add_index :infos, :user_id
  end
end
