class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  class << self
    def provides_callback_for provider
      class_eval %Q{
        def #{provider}
          @user = User.find_for_oauth env["omniauth.auth"], current_user

          if @user.persisted?
            sign_in @user, event: :authentication
            if @user.email_verified?
              redirect_to edit_user_registration_path
            else
              redirect_to finish_signup_path(@user)
            end
            set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
          else
            session["devise.#{provider}_data"] = env["omniauth.auth"]
            redirect_to new_user_registration_url
          end
        end
      }
    end
  end

  [:facebook].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for resource
    if resource.email_verified?
      super resource
    else
      finish_signup_path resource
    end
  end

  def google_oauth2
    @user = User.find_for_google_oauth2 request.env["omniauth.auth"], current_user
    if @user.persisted?
      flash[:notice] = t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
