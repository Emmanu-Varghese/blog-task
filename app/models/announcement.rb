class Announcement < ApplicationRecord
  TYPES = %w[new fix update].freeze

  after_initialize :set_defaults

  validates :announcement_type, :description, :name, :published_at, presence: true
  validates :announcement_type, inclusion: { in: TYPES }
  after_commit :indicate_new_announcement, on: [:create]

  def set_defaults
    self.published_at      ||= Time.zone.now
    self.announcement_type ||= TYPES.first
  end

  broadcasts_to ->(_announcements) { :announcement_list }, inserts_by: :prepend

  def indicate_new_announcement
    broadcast_update_to("announcement_notification", target: "announcements-link", partial: "shared/announcements_link")
  end
end
