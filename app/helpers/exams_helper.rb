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
end
