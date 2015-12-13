class AddWhoIdToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :who_id, :integer
    remove_column :comments, :author, :string
    add_column :comments, :author_id, :integer
  end
end
