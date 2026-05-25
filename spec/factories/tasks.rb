FactoryBot.define do
  factory :task do
    content { Faker::Lorem.sentence }
    difficulty { :normal }
    priority { :middle }
    completed { false }
    association :user
  end
end