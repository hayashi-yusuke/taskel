User.find_or_create_by!(email_address: "guest@example.com") do |user|
  user.name = "ゲストユーザー"
  user.password = "password"
  user.password_confirmation = "password"
end