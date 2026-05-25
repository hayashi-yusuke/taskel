require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "ログインしていない場合" do
    it "タスクを作成しようとするとログインページにリダイレクトされること" do
      post tasks_path
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "ログインしている場合" do
    before do
      @user = create(:user)
      post session_path, params: { email_address: @user.email_address, password: "password" }
    end

    describe "他のユーザーのタスクに対して" do
      before do
        @other_user = create(:user)
        @other_task = create(:task, user: @other_user)
      end
      
      it "タスク編集しようとするとマイページにリダイレクトされること" do
        get edit_task_path(@other_task)
        expect(response).to redirect_to(tasks_path)
      end
        
      it "タスク削除しようとするとリダイレクトされること" do
        delete task_path(@other_task)
        expect(response).to redirect_to(tasks_path)
      end
    end
  end
end