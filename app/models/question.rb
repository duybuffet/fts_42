class Question < ActiveRecord::Base
  enum question_type: [:single, :multiple, :text]
  enum status: [:waiting, :approved]

  belongs_to :subject
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  validates :content, presence: true
  validates :question_type, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|ans| ans["content"].blank?}
end
