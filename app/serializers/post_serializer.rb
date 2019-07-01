class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :publish_date, :author, :content, :source, :img_url, :link, :slant, :topic

  has_many :comments
  has_many :likes
end
