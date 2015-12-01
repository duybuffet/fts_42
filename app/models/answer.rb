class Answer < ActiveRecord::Base
  belongs_to :question
  validates :content, presence: true

  scope :correct_answer, -> {where correct: true}
end
