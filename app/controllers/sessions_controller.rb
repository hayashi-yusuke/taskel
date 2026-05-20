class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create guest_login]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    if Current.user.email_address == "guest@example.com"
      Current.user.tasks.destroy_all
      Current.user.update(name: "ゲストユーザー")
    end
    terminate_session
    redirect_to about_path, status: :see_other
  end

  def guest_login
    user = User.find_by(email_address: "guest@example.com")
    start_new_session_for user
    redirect_to mypage_path
  end
end
