class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to new_user_session_path, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :chatwork_id]
    devise_parameter_sanitizer.for(:account_update) << [:name, :chatwork_id]
  end

  def load_subjects
    @subjects = Subject.all
  end
end
