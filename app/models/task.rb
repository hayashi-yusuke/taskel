class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  enum :difficulty, { easy: 1, normal: 2, hard: 3 }
  enum :priority, { low: 1, middle: 2, high: 3 }

  validates :content, presence: true

  scope :by_status, ->(status) {
    case status
    when "completed" then where(completed: true)
    when "all"       then all
    else                  where(completed: false)
    end
  }
  scope :by_difficulty, ->(difficulty) { where(difficulty: difficulty) if difficulty.present? }
  scope :by_priority, ->(priority) { where(priority: priority) if priority.present? }
  scope :search_content, ->(q) { where("content LIKE ?", "%#{q}%") if q.present? }
  scope :sort_by_option, ->(sort) {
    case sort
    when "oldest"            then order(created_at: :asc)
      when "difficulty_high" then order(difficulty: :desc)
      when "difficulty_low"  then order(difficulty: :asc)
      when "priority_high"   then order(priority: :desc)
      when "priority_low"    then order(priority: :asc)
      when "likes"           then left_joins(:likes).group(:id).order("COUNT(likes.id) DESC")
      else                        order(created_at: :desc)
    end
  }
end
