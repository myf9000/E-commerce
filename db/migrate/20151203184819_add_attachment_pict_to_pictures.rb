class AddAttachmentPictToPictures < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.attachment :pict
    end
  end

  def self.down
    remove_attachment :pictures, :pict
  end
end
