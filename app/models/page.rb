class Page < ApplicationRecord
  validates :title, uniqueness: { scope: :id, conditions: -> { where(deleted: false) } }
  validates :title, :body, presence: true
end
