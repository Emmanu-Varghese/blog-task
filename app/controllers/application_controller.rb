class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :turbo_frame_request_variant

  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:alert] = exception.message
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
      format.turbo_stream { render turbo_stream: turbo_stream.update("flash", partial: "shared/notices") }
      format.js { render file: "app/views/shared/unauthorized.js.erb" }
    end
  end

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def process(action, *args)
    super
  rescue AbstractController::ActionNotFound => e
    respond_to do |format|
      format.html { redirect_to root_path, alert: e.message }
      format.json { render json: e.message, status: :unprocessable_entity }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.html { redirect_to root_path, alert: e.message }
      format.json { render json: e.message, status: :unprocessable_entity }
    end
  end
end
