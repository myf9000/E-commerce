class AddPaperClipAvatarToProducts < ActiveRecord::Migration
   def up
    add_attachment :products, :avatar
  end

  def down
    remove_attachment :products, :avatar
  end
end
