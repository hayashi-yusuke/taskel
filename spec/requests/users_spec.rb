require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "ログインしていない場合" do
    it "マイページにアクセスするとログインページにリダイレクトされること" do
      get mypage_path
      expect(response).to redirect_to(new_session_path)
    end

    it "タスク一覧にアクセスするとログインページにリダイレクトされること" do
      get tasks_path
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "ログインしている場合" do
    before do
      @user = create(:user)
      post session_path, params: { email_address: @user.email_address, password: "password" }
    end

    it "マイページにアクセスできること" do
      get mypage_path
      expect(response).to have_http_status(:ok)
    end
  end
end
