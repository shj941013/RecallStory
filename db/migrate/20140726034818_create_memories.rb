class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :description

      t.timestamps
    end
  end
end
