class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  attr_readonly :user_id
  validates :body, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :emotes, dependent: :destroy

  after_create_commit do
    broadcast_append_to [commentable, :comments],
                        target: "#{dom_id(commentable)}_comments"
  end
  after_update_commit do
    broadcast_replace_to [commentable, :comments]
  end
  after_destroy_commit do
    broadcast_remove_to [commentable, :comments]
  end
  # broadcasts_to ->(_comment) { :comments }

  def emotes_size(key)
    emotes.count { |e| e.emoji == key }
  end
end
