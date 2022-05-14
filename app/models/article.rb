class Article < ApplicationRecord
  FILTER_PARAMS = %i[user_id].freeze

  validates :title, :body, presence: true
  belongs_to :user
  has_many :comments, as: :commentable
  after_create :create_announcement

  # after_create_commit ->(_article) { broadcast_prepend_to :articles, partial: "articles/article_preview" }
  after_update_commit ->(_article) { broadcast_replace_to :articles, partial: "articles/article_preview" }
  after_destroy_commit ->(_article) { broadcast_remove_to :articles }
  broadcasts_to ->(_article) { :article }

  scope :by_user, ->(user_id) { where(user_id: user_id) if user_id.present? }

  def self.filter(filters)
    Article.includes(:user)
      .by_user(filters["user_id"])
  end

  private

  def create_announcement
    Announcement.create(
      announcement_type: "new",
      name: "New Article published by #{user.name}",
      description: "New Article published by #{user.name}",
    )
  end
end
