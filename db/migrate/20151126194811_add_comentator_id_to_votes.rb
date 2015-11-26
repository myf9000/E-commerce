class AddComentatorIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :comentator_id, :integer
  end
end
