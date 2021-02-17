class User < ApplicationRecord
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: { case_sensitive: false }
  before_validation :downcase_email
  has_secure_password

  private
  def downcase_email
    self.email = self.email.downcase
  end
end
