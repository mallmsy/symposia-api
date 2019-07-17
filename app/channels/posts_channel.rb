class PostsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_channel"
  end

  def unsubscribed
    raise "steak"
  end
end
