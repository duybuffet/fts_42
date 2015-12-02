class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :results, dependent: :destroy

  enum status: [:start, :uncheck, :checked, :testing]

  before_create :create_questions
  after_update :send_exam_result, if: :uncheck?

  accepts_nested_attributes_for :results, allow_destroy: true

  scope :order_desc, ->{order created_at: :desc}

  scope :created_long_ago, ->{where "created_at <= ?", 8.hours.ago}

  scope :created_nearly, ->{where "created_at > ?", 8.hours.ago}

  def score
    self.results.select{|item| item.correct}.size
  end

  def time_remaining
    Settings.exams.duration * Settings.exams.time_minute - self.spent_time.to_i
  end

  def time_spent
    self.spent_time.to_i + (Time.zone.now - self.updated_at).to_i
  end

  class << self
    def check_exam_daily
      Exam.created_long_ago.start.destroy_all
      Exam.created_nearly.each do |exam|
        UserMailer.send_exam_remainder(exam).deliver_now
      end
    end

    def check_exam_monthly
      Exam.start.destroy_all
    end
  end

  def auto_check_exam
    self.results.each do |result|
      result.update_attributes correct: result.check_correct_answer
    end
    self.update_attributes status: :checked
  end

  private
  def create_questions
    Subject.find(self.subject_id).questions.
      order("RANDOM()").limit(Settings.exams.question_number).each do |question|
        self.results.build question_id: question.id
    end
  end

  def send_exam_result
    SendExamResult.perform_async self.id
  end
end
