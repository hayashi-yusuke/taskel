class Admin::UsersController < Admin::ApplicationController
  def index
    if params[:q].present?
      @users = User.where("name LIKE ?", "%#{params[:q]}%").page(params[:page]).per(20)
    else
      @users = User.all.page(params[:page]).per(20)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end
end
