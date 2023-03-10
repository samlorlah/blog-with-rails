class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_post_counter

  def update_post_counter
    author.increment!(:post_counter)
  end

  def update_post_counter_when_post_deleted
    author.decrement!(:post_counter)
  end

  def five_recent_comments
    comments.order(created_at: :desc).last(5)
  end
end
