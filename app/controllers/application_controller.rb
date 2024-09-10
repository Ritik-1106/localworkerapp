class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def after_sign_in_path_for(resource)
    root_path # This redirects the user to the home page after login
  end
  # this methods basically permit to centain attributes that is required while signup
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :role, :name, :contact_no, :location ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :role, :name, :contact_no, :location  ])
  end
end
