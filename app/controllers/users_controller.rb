class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]

  def mypage
    @task = Task.new
  end

  def index
    if params[:user_q].present?
      @users = User.where("name LIKE ?", "%#{params[:user_q]}%")
    else
      @users = User.none
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "登録が完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.where(completed: false)
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def edit
    if params[:id].to_i != Current.user.id
      redirect_to mypage_path, alert: "アクセスできません"
      return
    end
    @user = Current.user
  end

  def update
    @user = Current.user

    if Current.user.email_address == "guest@example.com"
      if user_params[:email_address].present? || user_params[:password].present?
        redirect_to mypage_path, alert: "ゲストユーザーはメールアドレスとパスワードを変更できません"
        return
      end
    end

    if @user.update(user_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Current.user.destroy
    terminate_session
    redirect_to root_path, notice: "アカウントを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
