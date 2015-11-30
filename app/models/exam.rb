class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :results, dependent: :destroy

  enum status: [:start, :uncheck, :checked, :testing]

  before_create :create_questions

  accepts_nested_attributes_for :results, allow_destroy: true

  scope :order_desc, ->{order created_at: :desc}

  def score
    self.results.select{|item| item.correct}.size
  end

  def time_remaining
    Settings.exams.duration * Settings.exams.time_minute - self.spent_time.to_i
  end

  def time_spent
    self.spent_time.to_i + (Time.zone.now - self.updated_at).to_i
  end

  private
  def create_questions
    Subject.find(self.subject_id).questions.
      order("RANDOM()").limit(Settings.exams.question_number).each do |question|
        self.results.build question_id: question.id
    end
  end
end
