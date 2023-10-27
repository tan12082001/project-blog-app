class User < ApplicationRecord
  has_many :post, foreign_key: 'author_id'
  has_many :comment
  has_many :like

  def three_recent_posts
    Post.order(created_at: :desc).limit(3)
  end
end
