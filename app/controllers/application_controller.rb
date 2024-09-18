class ApplicationController < ActionController::Base
  # allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def after_sign_in_path_for(resource)
    if current_user.contractor?
      contractor_path
    elsif current_user.worker?
      # Use `main_app` to reference routes outside of the Devise scope
      if current_user.profile.nil?
        main_app.new_profile_path
      else
        worker_path
      end
    else
      root_path
    end
  end



  # this methods basically permit to centain attributes that is required while signup
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :role, :name, :contact_no, :location ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :role, :name, :contact_no, :location  ])
  end
end
