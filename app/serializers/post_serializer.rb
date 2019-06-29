class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :publish_date, :author, :content, :source, :img_url, :link, :slant

  has_many :comments
  has_many :likes
  has_many :users, through: :comments
end
