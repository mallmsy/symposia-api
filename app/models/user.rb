class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, through: :likes
  has_many :posts, through: :comments

  has_secure_password
  validates :username, uniqueness: { case_sensitive: false}
end
