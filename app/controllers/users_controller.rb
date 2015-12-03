class UsersController < ApplicationController
  load_and_authorize_resource

  def edit
  end

  def update
    if @user.update user_params
      sign_in(@user == current_user ? @user : current_user, bypass: true)
      redirect_to @user
    else
      render :edit
    end
  end

  def finish_signup
    if request.patch? && params[:user]
      if @user.update user_params
        sign_in @user, bypass: true
        redirect_to @user
      else
        @show_errors = true
      end
    end
  end

  private
  def user_params
    accessibles = [:name, :email]
    accessibles << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit accessibles
  end
end
