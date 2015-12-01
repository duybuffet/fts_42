class Admin::UsersController < Admin::DashboardController
  load_resource

  def index
    @users = @users.page params[:page]
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "admin.update_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.delete_success"
      redirect_to admin_users_path
    else
      flash.now[:danger] = t "admin.delete_fail"
      render :index
    end
  end

  private
  def user_params
    params.require(:user).permit :role
  end
end
