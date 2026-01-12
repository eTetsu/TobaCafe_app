class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  add_flash_types :success, :danger

  before_action :require_login

  private

  def not_authenticated
    redirect_to root_path, alert: "ログインしてください。"
  end
end
