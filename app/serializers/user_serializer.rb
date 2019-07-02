class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :bio, :slant, :img_url, :likes

  has_many :comments
  has_many :posts, through: :likes
end
