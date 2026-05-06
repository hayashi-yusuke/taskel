class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def mypage
    @task = Task.new
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

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user
    if @user.update(user_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "アカウントを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end

end
