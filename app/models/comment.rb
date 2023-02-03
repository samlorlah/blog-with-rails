class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comments_counter

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def update_comment_counter_when_comment_deleted
    post.decrement!(:comments_counter)
  end
end
