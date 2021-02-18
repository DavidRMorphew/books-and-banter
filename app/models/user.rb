class User < ApplicationRecord
  has_many :checkouts, foreign_key: :borrower_id
  has_many :borrowed_books, through: :checkouts, source: :borrowed_book
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: { case_sensitive: false }
  before_validation :downcase_email
  has_secure_password

  private
  def downcase_email
    self.email = self.email.downcase
  end
end
