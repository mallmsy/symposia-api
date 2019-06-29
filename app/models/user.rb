class User < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts, through: :likes
  has_many :posts, through: :comments

  has_secure_password
  validates :username, uniqueness: { case_sensitive: false}
end
