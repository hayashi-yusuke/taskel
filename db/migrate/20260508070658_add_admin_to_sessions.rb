class AddAdminToSessions < ActiveRecord::Migration[8.1]
  def change
    add_reference :sessions, :admin, foreign_key: true
    change_column_null :sessions, :user_id, true
  end
end
