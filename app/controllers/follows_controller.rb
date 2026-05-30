class FollowsController < ApplicationController
  before_action :set_user
  def create
    follow = Current.user.active_relationships.build(following: @user)

    if follow.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: root_path, notice: "フォローしました！" }
      end
    else
      redirect_back fallback_location: root_path, alert: "フォローに失敗しました"
    end
  end

  def destroy
    follow = Current.user.active_relationships.find_by(following: @user)
    follow&.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path, notice: "フォローを解除しました" }
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
