class LikesController < ApplicationController

  def index
    @tasks = Current.user.likes.includes(:task).map{|like| like.task }
  end

  def create
    @task = Task.find(params[:task_id])
    like = Current.user.likes.build(task: @task)

    if like.save
      redirect_back fallback_location: root_path, notice: "エールを送りました！"
    else
      redirect_back fallback_location: root_path, alert: "エールに失敗しました"
    end
  end

  def destroy
    @task = Task.find(params[:task_id])
    like = Current.user.likes.find_by(task: @task)
    like&.destroy
    redirect_back fallback_location: root_path, notice: "エールを取り消しました"
  end
end
