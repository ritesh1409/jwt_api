class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: :password_required?

  enum role: { client: 0, agent: 1, selling_agent: 2, inspector: 3, admin: 4 }

  before_create :set_default_role

  private

  def password_required?
    password_digest.blank? || !password.nil?
  end

  def set_default_role
    self.role ||= :client
  end
end
