class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # belongs_to :user_type

  has_one :user_info, dependent: :destroy
  has_many :enrollements, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,:registerable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, allow_blank: false, uniqueness: true

  # before_destroy :disallow_destroy

  # self.skip_session_storage = [:http_auth]

  def jwt_payload
    super.merge('id' => id, email: email)
  end

  def send_activation_mail
		self.update_column(:confirm_token, SecureRandom.urlsafe_base64)
		self.update_column(:confirm_mail_sent_at, Time.zone.now)
		UserMailer.activate_account(self).deliver
  end

  private

  def disallow_destroy
    # Delete only allowed from Core.
    raise "Cannot delete user"
  end
end