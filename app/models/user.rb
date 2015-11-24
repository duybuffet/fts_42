class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  enum role: [:member, :admin]
  validates :name, presence: true
  validates :chatwork_id, presence: true
end
