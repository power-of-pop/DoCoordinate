class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :error404

  def error404(error = nil)
    Rails.logger.error("❌#{error.message}") if error
    render template: 'errors/error404', layout: 'static_page', status: :not_found
  end
end
