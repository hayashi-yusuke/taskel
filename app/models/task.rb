class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  enum :difficulty, { easy: 1, normal: 2, hard: 3 }
  enum :priority, { low: 1, middle: 2, high: 3 }

  validates :content, presence: true
end
