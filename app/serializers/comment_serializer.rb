class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :post_id, :user
  has_one :user
  belongs_to :post
end
