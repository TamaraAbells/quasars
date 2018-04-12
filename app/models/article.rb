class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :user, :title, :url, presence: true
  validates :url, uniqueness: true

  scope :hot, -> { Article.order(created_at: :desc).order(karma: :desc) }

  def upvoted_by_user?(user)
    votes.where(user: user).any?
  end
end
