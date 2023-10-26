class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum:6}

end
