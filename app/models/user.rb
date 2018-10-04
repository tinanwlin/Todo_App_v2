class User < ApplicationRecord
  has_secure_password
  before_save :normalize_name, on: :create

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: { case_sensetive: false }
  validates :password, length: { minimum: 3 }

  private
    def normalize_name
      self.email = email.downcase
    end
end
