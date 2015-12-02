class SendExamResult
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform exam_id
    exam = Exam.find exam_id
    exam.auto_check_exam
    UserMailer.send_exam_result(exam).deliver_now
  end
end
