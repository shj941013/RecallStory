class CreateMemories < ActiveRecord::Migration
  def change
    add_column :memories, :user_id, :integer
    add_index :memories, :user_id

      t.timestamps
    end
  end
end
