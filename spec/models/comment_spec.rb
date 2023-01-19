require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(
    name: 'Doe John',
    photo: 'http://photo.com',
    post_counter: 0
  )

  post = Post.create(
    title: 'Title',
    text: 'The title of the post',
    comments_counter: 0,
    likes_counter: 0,
    author_id: user.id
  )

  comment = Comment.create(post: post, author: user)

  context 'update_comments_counter' do
    comment.update_comments_counter

    it 'should increment comments_counter' do
      expect(Post.find(post.id).comments_counter).eql?(post.comments_counter + 1)
    end
  end
end