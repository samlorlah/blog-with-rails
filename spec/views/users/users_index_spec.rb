require 'rails_helper'

RSpec.describe 'user/#index', type: :feature do
  before :each do
    visit users_path
    @users = User.all
  end
  describe 'users index view' do
    it 'should show the names of all users' do
      @users.each { |user| expect(page).to have_content(user.name) }
    end

    it 'should show the number of posts of each user' do
      @users.each { |user| expect(page).to have_content "Number of posts: #{user.post_counter}" }
    end

    it 'should show the profile picture of each user' do
      @users.each { |user| expect(page).to have_css("img[src*='#{user.photo}']") }
    end

    it 'Redirects to user show page when a user is clicked' do
      user = @users.first
      find("a[href='#{user_path(user.id)}']").click
      expect(current_path).to match user_path(user.id)
    end
  end
end