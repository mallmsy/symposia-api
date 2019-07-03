class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :post_id, :user_id
  has_one :user
  belongs_to :post
end
