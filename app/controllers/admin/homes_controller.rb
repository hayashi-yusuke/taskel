class Admin::HomesController < Admin::ApplicationController
  def top
    @user_count = User.count
    @task_count = Task.count
  end
end