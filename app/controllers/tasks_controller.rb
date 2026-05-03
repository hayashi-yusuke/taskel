class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      redirect_to mypage_path, notice: "タスクを作成しました"
    else
      redirect_to mypage_path, alert: "タスクの作成に失敗しました"
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to mypage_path, notice: "編集が完了しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
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
    params.require(:task).permit(:content, :difficulty, :priority ) 
  end
end
