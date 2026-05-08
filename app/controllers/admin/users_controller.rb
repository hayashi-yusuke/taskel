class Admin::UsersController < Admin::ApplicationController
  def index
    if params[:q].present?
      @users = User.where("name LIKE ?", "%#{params[:q]}%")
    else
      @users = User.all
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end
end