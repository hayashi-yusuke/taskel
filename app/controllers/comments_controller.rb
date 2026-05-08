class CommentsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(comment_params)
    @comment.user = Current.user
    if @comment.save
      redirect_to @task, notice: "コメントを投稿しました"
    else
      redirect_to @task, alert: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @task = Task.find(params[:task_id])
    @comment = @task.comments.find(params[:id])
    @comment.destroy
    redirect_to @task, notice: "コメントを削除しました"
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
