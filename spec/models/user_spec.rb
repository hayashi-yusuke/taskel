require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効な属性を持つユーザーは保存できること" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "名前が空の場合は無効であること" do
    user = build(:user, name: "")
    expect(user).not_to be_valid
  end

  it "メールアドレスが空の場合は無効であること" do
    user = build(:user, email_address: "")
    expect(user).not_to be_valid
  end

  it "メールアドレスが重複している場合は無効であること" do
    create(:user, email_address: "test@example.com")
    user = build(:user, email_address: "test@example.com")
    expect(user).not_to be_valid
  end
end
