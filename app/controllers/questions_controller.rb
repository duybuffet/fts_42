class QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, except: [:destroy, :index]

  def index
    @q = current_user.questions.ransack params[:q]
    @questions = @q.result.page params[:page]
  end

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

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "update_success"
      redirect_to questions_path
    else
      flash[:danger] = t "update_fail"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_fail"
    end
    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit :subject_id, :content, :question_type,
      :status, :user_id, answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
