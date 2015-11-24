class Result < ActiveRecord::Base
  belongs_to :answer
  belongs_to :exam
  belongs_to :question
end
