class CommentSerializer < ApplicationSerializer
  attributes :id, :body
  belongs_to :user
  has_many :emotes
end
