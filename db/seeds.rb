Admin.find_or_create_by!(email_address: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

User.find_or_create_by!(email_address: "guest@example.com") do |user|
  user.name = "ゲストユーザー"
  user.password = "password"
  user.password_confirmation = "password"
end

users_data = [
  { name: "田中 太郎", email_address: "taro@example.com" },
  { name: "佐藤 花子", email_address: "hanako@example.com" },
  { name: "鈴木 一郎", email_address: "ichiro@example.com" },
  { name: "高橋 美咲", email_address: "misaki@example.com" },
  { name: "伊藤 健太", email_address: "kenta@example.com" },
  { name: "渡辺 さくら", email_address: "sakura@example.com" },
  { name: "山本 拓也", email_address: "takuya@example.com" },
  { name: "中村 あかり", email_address: "akari@example.com" },
  { name: "小林 翔太", email_address: "shota@example.com" }
]

users_data.each do |data|
  User.find_or_create_by!(email_address: data[:email_address]) do |user|
    user.name = data[:name]
    user.password = "password"
    user.password_confirmation = "password"
  end
end

task_contents = [
  "Railsの復習をする",
  "GitHubにpushする",
  "朝のランニングをする",
  "読書を30分する",
  "買い物リストを作る",
  "部屋の掃除をする",
  "友達に連絡する",
  "英語の勉強をする",
  "ポートフォリオを更新する",
  "日報を書く",
  "筋トレをする",
  "料理を作る",
  "映画を1本見る",
  "睡眠時間を記録する",
  "次週の計画を立てる"
]

difficulties = [ :easy, :normal, :hard ]
priorities   = [ :low, :middle, :high ]

User.all.each do |user|
  8.times do |i|
    Task.find_or_create_by!(
      user_id: user.id,
      content: task_contents[i % task_contents.length]
    ) do |task|
      task.difficulty = difficulties.sample
      task.priority   = priorities.sample
      task.completed  = i < 3
    end
  end
end

users = User.all
tasks = Task.all

users.each do |user|
  tasks.where.not(user_id: user.id).sample(5).each do |task|
    Like.find_or_create_by!(user_id: user.id, task_id: task.id)
  end
end

users.each do |user|
  users.where.not(id: user.id).sample(3).each do |other_user|
    Relationship.find_or_create_by!(
      follower_id: user.id,
      following_id: other_user.id
    )
  end
end

comment_contents = [
  "頑張ってください！",
  "一緒に頑張りましょう！",
  "素晴らしいですね！",
  "応援しています！",
  "いいですね！",
  "継続は力なり！",
  "毎日コツコツ大事ですね！",
  "お互い頑張りましょう！"
]

users.each do |user|
  tasks.where.not(user_id: user.id).sample(3).each do |task|
    Comment.find_or_create_by!(user_id: user.id, task_id: task.id) do |comment|
      comment.content = comment_contents.sample
    end
  end
end

puts "シードデータの投入が完了しました！"
puts "ユーザー数：#{User.count}人"
puts "タスク数：#{Task.count}個"
puts "エール数：#{Like.count}個"
puts "フォロー数：#{Relationship.count}件"
puts "コメント数：#{Comment.count}件"
