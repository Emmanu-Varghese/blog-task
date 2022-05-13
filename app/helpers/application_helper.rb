module ApplicationHelper
  include Pagy::Frontend

  def user_settings_page?
    return true if controller_name == "users" && action_name == "edit"

    false
  end
end
