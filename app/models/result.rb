class Result < ActiveRecord::Base
  serialize :content_answer, Array
  belongs_to :answer
  belongs_to :exam
  belongs_to :question

  def check_correct_answer
    if self.exam.checked?
      self.correct
    else
      if self.question.text?
        self.content_answer[0] == self.question.answers.correct_answer[0].content
      else
        (self.question.answers.correct_answer.ids.map{|id| id.to_s} -
          self.content_answer).empty? && self.question.answers.correct_answer.size ==
          self.content_answer.size
      end
    end
  end
end
