class DropCommentsHierarchy < ActiveRecord::Migration
  def up
    drop_table :comment_hierarchies
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
