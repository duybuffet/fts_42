class Admin::ExamsController < Admin::DashboardController
  load_resource

  def index
    @exams = @exams.order_desc.page params[:page]
  end

  def show
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "exams.update_success"
    else
      flash[:danger] = t "exams.update_fails"
    end
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :user_id, :status, :subject_id, results_attributes: [
      :id, :question_id, :correct, content_answer: []]
  end
end
