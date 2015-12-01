class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, except: [:destroy, :index]

  def index
    @q = @questions.ransack params[:q]
    @questions = @q.result.page params[:page]
  end

  def show
  end

  def new
    @question.answers.new
  end

  def create
    if @question.save
      flash[:success] = t "admin.add_success"
      redirect_to new_admin_question_path
    else
      flash.now[:danger] = t "admin.add_fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "admin.update_success"
      redirect_to admin_questions_path
    else
      flash[:danger] = t "admin.update_fail"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "admin.delete_success"
    else
      flash[:danger] = t "admin.delete_fail"
    end
    redirect_to admin_questions_path
  end

  private
  def question_params
    params.require(:question).permit :subject_id, :content, :question_type,
      :status, :user_id, answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
