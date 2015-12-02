class UserMailer < ApplicationMailer
  def send_exam_remainder exam
    @exam = exam
    @user = exam.user
    mail to: @user.email
  end
end
