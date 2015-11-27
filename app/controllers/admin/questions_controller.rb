class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, only: [:new, :create]

  def index
    @q = @questions.ransack params[:q]
    @questions = @q.result.page params[:page]
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

  private
  def load_subjects
    @subjects = Subject.all
  end

  def question_params
    params.require(:question).permit :subject_id, :content, :question_type,
      :status, :user_id, answers_attributes: [:content, :correct, :_destroy]
  end
end
