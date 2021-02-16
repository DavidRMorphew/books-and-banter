class User < ApplicationRecord
  validates :username, :email, presence: true
  has_secure_password
end
