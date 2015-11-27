class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  enum question_type: [:single, :multiple, :text]
  enum status: [:waiting, :approved, :cancel]

  validates :content, presence: true
  validates :question_type, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|ans| ans["content"].blank?}
end
