require 'rails_helper'

RSpec.describe Task, type: :model do
  it "有効な属性を持つタスクは保存できること" do
    task = build(:task)
    expect(task).to be_valid
  end

  it "contentが空の場合は無効であること" do
    task = build(:task, content: "")
    expect(task).not_to be_valid
  end
end
