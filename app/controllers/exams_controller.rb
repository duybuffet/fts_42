class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = current_user.exams.new
    @subjects = Subject.all
    @exams = @exams.page params[:page]
  end

  def create
    if @exam.save
      flash[:success] = t "exams.index.success_create"
    else
      flash[:danger] = t "exams.index.fails_create"
    end
    redirect_to exams_path
  end

  def update
  end

  private
  def exam_params
    params.require(:exam).permit :user_id, :status, :subject_id, results_attributes: [
      :id, :answer_id, :question_id]
  end
end
