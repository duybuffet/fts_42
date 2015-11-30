class Result < ActiveRecord::Base
  serialize :content_answer, Array
  belongs_to :answer
  belongs_to :exam
  belongs_to :question
end
