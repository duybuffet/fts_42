class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = current_user.exams.new
    @subjects = Subject.all
    @exams = @exams.order_desc.page params[:page]
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
    @exam.spent_time = @exam.time_spent
    if @exam.update_attributes exam_params
      flash[:success] = t "exams.update_success"
    else
      flash[:danger] = t "exams.update_fails"
    end
    redirect_to exams_path
  end

  def show
     @time_remaining = @exam.time_remaining
     @is_time_over = @time_remaining < 0
  end

  private
  def exam_params
    params.require(:exam).permit :user_id, :status, :subject_id, results_attributes: [
      :id, :question_id, content_answer: []]
  end
end
