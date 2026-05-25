class LikesController < ApplicationController
  def index
    @tasks = Current.user.likes.includes(:task).map { |like| like.task }
  end

  def create
    @task = Task.find(params[:task_id])
    like = Current.user.likes.build(task: @task)

    if like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: root_path, notice: "エールを送りました！" }
      end
    else
      redirect_back fallback_location: root_path, alert: "エールに失敗しました"
    end
  end

  def destroy
    @task = Task.find(params[:task_id])
    like = Current.user.likes.find_by(task: @task)
    like&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path, notice: "エールを取り消しました" }
    end
  end
end
