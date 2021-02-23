class User < ApplicationRecord
  has_many :checkouts, foreign_key: :borrower_id
  has_many :borrowed_books, through: :checkouts, source: :borrowed_book
  has_many :reviews, foreign_key: :reviewer_id
  has_many :reviewed_books, through: :reviews, source: :reviewed_book
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: { case_sensitive: false }
  before_validation :downcase_email
  has_secure_password

  def self.create_from_omniauth(auth)
    User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex(16)
    end
  end

  private
  def downcase_email
    self.email = self.email.downcase
  end
end
