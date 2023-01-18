class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  after_save :update_post_counter

  def update_post_counter
    author.increment!(:post_counter)
  end

  def five_recent_comments
    comments.order(created_at: :desc).last(5)
  end
end
