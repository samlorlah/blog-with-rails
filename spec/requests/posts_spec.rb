require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.create(
      name: 'Doe John',
      photo: 'http://placeimg.com/640/480/any',
      bio: 'I am a develpoer',
      post_counter: 2
    )

    @post = Post.create(
      author: @user,
      title: 'My test post',
      text: 'This is my test post',
      comments_counter: 1,
      likes_counter: 5
    )
  end

  describe 'GET #index' do
    before(:each) { get user_posts_path(@user) }
    it 'return correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:index)
    end

    it 'body should includes correct placeholder text' do
      expect(response.body).to include('List of Posts')
    end
  end

  describe 'GET #show' do
    before(:each) { get user_post_path(@user, @post) }
    it 'return correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:show)
    end

    it 'body should includes correct placeholder text' do
      expect(response.body).to include('Post Details')
    end
  end
end
