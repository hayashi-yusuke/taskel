class FollowsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    follow = Current.user.active_relationships.build(following: @user)
    
    if follow.save
      redirect_back fallback_location: root_path, notice: "フォローしました！"
    else
      redirect_back fallback_location: root_path, alert: "フォローに失敗しました"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    follow = Current.user.active_relationships.find_by(following: @user)
    follow&.destroy
    redirect_back fallback_location: root_path, notice: "フォローを解除しました"
  end
end
