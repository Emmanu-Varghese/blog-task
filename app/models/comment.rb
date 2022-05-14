class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_rich_text :content
  has_many :emotes, dependent: :destroy

  def emotes_size(key)
    self.emotes.select { |e| e.emoji == key }.size
  end
end
