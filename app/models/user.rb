class User < ApplicationRecord
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: { case_sensitive: false }
  has_secure_password
end
