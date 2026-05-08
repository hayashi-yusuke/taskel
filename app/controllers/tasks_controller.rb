class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :authorize_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.where(completed: false)
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      redirect_to mypage_path, notice: "タスクを作成しました"
    else
      flash[:alert] = @task.errors.full_messages.join(", ")
      redirect_to mypage_path
    end
  end

  def show
    @task = Task.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to mypage_path, notice: "編集が完了しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to mypage_path, notice: "タスクを削除しました"
  end

  def complete
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect_to mypage_path
  end

  private

  def task_params
    params.require(:task).permit(:content, :difficulty, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def authorize_task
    if @task.user_id != Current.user.id
      redirect_to tasks_path, alert: "アクセスできません"
      return
    end
  end
end
