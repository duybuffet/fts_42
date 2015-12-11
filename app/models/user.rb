class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = "change@me"
  TEMP_EMAIL_REGEX = /\Achange@me/
  enum role: [:member, :admin]

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :omniauthable

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, length: {maximum: 100}
  validates :chatwork_id, presence: true
  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update

  class << self
    def find_for_oauth auth, signed_in_resource = nil
      identity = Identity.find_for_oauth auth

      user = signed_in_resource ? signed_in_resource : identity.user

      if user.nil?
        email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
        email = auth.info.email if email_is_verified
        user = User.find_by(email: email) if email

        if user.nil?
          user = User.new(
            name: auth.extra.raw_info.name,
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: "password"
          )
          user.save!
        end
      end

      if identity.user != user
        identity.user = user
        identity.save!
      end
      user
    end

    def find_for_google_oauth2 access_token, signed_in_resource = nil
      data = access_token.info
      user = User.find_by provider: access_token.provider, uid: access_token.uid
      if user
        user
      else
        registered_user = User.find_by email: access_token.info.email
        if registered_user
          registered_user
        else
          user = User.create(name: data["name"],
            provider:access_token.provider,
            email: data["email"],
            uid: access_token.uid,
            password: Devise.friendly_token[0,20])
        end
      end
    end
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end
