class CreateLikes < ActiveRecord::Migration[8.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :task_id, null: false
      t.timestamps
    end

    add_index :likes, :user_id
    add_index :likes, :task_id
  end
end
