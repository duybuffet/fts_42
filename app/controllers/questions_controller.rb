class QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, only: [:new, :create]

  def new
    @question.answers.new
  end

  def create
    if @question.save
      flash[:success] = t "contribute_success"
      redirect_to new_question_path
    else
      flash.now[:danger] = t "contribute_fail"
      render :new
    end
  end

  def question_params
    params.require(:question).permit :subject_id, :content, :question_type,
      :status, :user_id, answers_attributes: [:content, :correct, :_destroy]
  end
end
