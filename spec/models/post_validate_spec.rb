require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Doe John',
      photo: 'http://photo.com',
      post_counter: 0
    )
  end

  subject do
    Post.new(
      title: 'Title',
      text: 'Text for the post at any length',
      comments_counter: 0,
      likes_counter: 0,
      author_id: @user.id
    )
  end

  before { subject.save }

  context 'check for valid data' do
    it 'should accept a title' do
      subject.title = 'New Title'
      expect(subject).to be_valid
    end
    it 'should accept a comments_counter that is 0 and greater' do
      subject.comments_counter = 2
      expect(subject).to be_valid
    end
    it 'should accept a likes_counter that is 0 and greater' do
      subject.likes_counter = 2
      expect(subject).to be_valid
    end
  end

  context 'check for invalid data' do
    it 'should not accept empty title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
    it 'should not accept empty title above 250 characters' do
      subject.title = 'Sed ut ghjhhh unde omnis iste natus error sit voluptatem accusantium
       doloremque gahhs, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi
        architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit
        aspernatur aut odit aut fugit, sed quia hjuut kkuud llppo '
      expect(subject).to_not be_valid
    end

    it 'should not accept comments_counter below 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should not accept comments_counter that is not numerical' do
      subject.comments_counter = 'a'
      expect(subject).to_not be_valid
    end

    it 'should not accept likes_counter below 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should not accept likes_counter that is not numerical' do
      subject.likes_counter = 'a'
      expect(subject).to_not be_valid
    end
  end
end
