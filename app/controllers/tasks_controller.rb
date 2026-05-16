class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :authorize_task, only: [:edit, :update, :destroy]

  def index
    @tasks = case params[:status]
             when "completed"
               Task.where(completed: true)
             when "all"
               Task.all
             else
               Task.where(completed: false)
             end
    @tasks = @tasks.where(difficulty: params[:difficulty]) if params[:difficulty].present?
    @tasks = @tasks.where(priority: params[:priority]) if params[:priority].present?
    @tasks = @tasks.where("content LIKE ?", "%#{params[:q]}%") if params[:q].present?
    
    @tasks = case params[:sort]
             when "oldest"
               @tasks.order(created_at: :asc)
             when "difficulty_high"
               @tasks.order(difficulty: :desc)
             when "difficulty_low"
               @tasks.order(difficulty: :asc)
             when "priority_high"
               @tasks.order(priority: :desc)
             when "priority_low"
               @tasks.order(priority: :asc)
             when "likes"
               @tasks.left_joins(:likes).group(:id).order("COUNT(likes.id) DESC")
             else
               @tasks.order(created_at: :desc)
             end
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
