require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.create(
    name: 'John',
    photo: 'http://photo.com',
    post_counter: 0
  )

  5.times.collect do
    Post.create(
      title: 'About me', text: 'About me and other text', comments_counter: 1,
      likes_counter: 0, author_id: user.id
    )
  end

  context 'recent_three_posts' do
    it 'return at most 3 posts' do
      expect(user.last_three_posts.length).to be_between(0, 3).inclusive
    end

    it 'should return 3 posts' do
      expect(user.last_three_posts.length).to eql(3)
    end
  end
end