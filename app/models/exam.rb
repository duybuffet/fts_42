class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :results, allow_destroy: true

  def score
    self.results.select{|item| item.correct}.size
  end
end
