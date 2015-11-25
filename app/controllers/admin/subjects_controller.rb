class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = @subjects.page params[:page]
  end

  def new
  end

  def create
    if @subject.save
      flash[:success] = t "admin.add_success"
      redirect_to admin_subjects_path
    else
      flash.now[:danger] = t "admin.add_fail"
      render :new
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "admin.delete_success"
      redirect_to admin_subjects_path
    else
      flash.now[:danger] = t "admin.delete_fail"
      render :index
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name
  end
end
