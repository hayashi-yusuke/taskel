class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :task_id, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :task_id
  end
end
