class LikesController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    like = Current.user.likes.build(task: @task)

    if like.save
      redirect_back fallback_location: root_path, notice: "いいねしました！"
    else
      redirect_back fallback_location: root_path, alert: "いいねに失敗しました"
    end
  end

  def destroy
    @task = Task.find(params[:task_id])
    like = Current.user.likes.find_by(task: @task)
    like&.destroy
    redirect_back fallback_location: root_path, notice: "いいねを取り消しました"
  end
end
