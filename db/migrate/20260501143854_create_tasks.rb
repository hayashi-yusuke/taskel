class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.boolean :completed, default: false, null: false
      t.integer :difficulty
      t.integer :priority

      t.timestamps
    end
  end
end