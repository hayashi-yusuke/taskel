class Admin::TasksController < Admin::ApplicationController
  def index
    if params[:q].present?
      @tasks = Task.where("content LIKE ?", "%#{params[:q]}%").page(params[:page]).per(20)
    else
      @tasks = Task.all.page(params[:page]).per(20)
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to admin_tasks_path, notice: "タスクを削除しました"
  end
end
