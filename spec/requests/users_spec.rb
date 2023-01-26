require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:each) do
    @user = User.create(
      name: 'Doe John',
      photo: 'http://placeimg.com/640/480/any',
      bio: 'I am a develpoer',
      post_counter: 2
    )
  end

  describe 'GET #index' do
    before(:each) { get users_path }
    it 'return correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:index)
    end

    it 'body should includes correct placeholder text' do
      expect(response.body).to include('List of Users')
    end
  end
  describe 'GET #show' do
    before(:each) { get user_path(@user) }

    it 'return correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:show)
    end

    it 'body should includes correct placeholder text' do
      expect(response.body).to include('User Profile')
    end
  end
end
