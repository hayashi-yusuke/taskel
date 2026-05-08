class Admin::TasksController < Admin::ApplicationController
  def index
    if params[:q].present?
      @tasks = Task.where("content LIKE ?", "%#{params[:q]}%")
    else
      @tasks = Task.all
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to admin_tasks_path, notice: "タスクを削除しました"
  end
end