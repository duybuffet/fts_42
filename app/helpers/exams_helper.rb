module ExamsHelper
  def status_exam exam
    case exam.status
    when Settings.exams.status.start
      content_tag :span, t("exams.status.start"), class: "label label-primary"
    when Settings.exams.status.checked
      content_tag :span, t("exams.status.checked"), class: "label label-success"
    when Settings.exams.status.uncheck
      content_tag :span, t("exams.status.uncheck"), class: "label label-danger"
    when Settings.exams.status.testing
      content_tag :span, t("exams.status.testing"), class: "label label-warning"
    end
  end

  def check_correct_answer result
    if result.question.text?
      result.content_answer[0] == result.question.answers.correct_answer[0].content
    else
      (result.question.answers.correct_answer.ids.map{|id| id.to_s} -
        result.content_answer).empty? && result.question.answers.correct_answer.size ==
        result.content_answer.size
    end
  end
end
