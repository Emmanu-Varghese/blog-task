# frozen_string_literal: true

class AnnouncementComponent < ViewComponent::Base
  include AnnouncementsHelper
  attr_reader :announcement

  def initialize(announcement:)
    super
    @announcement = announcement
  end
end
