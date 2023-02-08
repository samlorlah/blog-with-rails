require 'rails_helper'

RSpec.describe 'user_posts/#index', type: :feature do
  before :each do
    @user = User.first
    visit user_posts_path(@user.id)
  end
  describe 'Users Posts index view' do
    it 'should show user profile picture' do
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end
    it 'should show user username' do
      expect(page).to have_content(@user.name)
    end
    it 'should show the number of posts the user have written' do
      expect(page).to have_content("Number of posts: #{@user.post_counter}")
    end
    it "should show the post's title" do
      @user.posts.each { |post| expect(page).to have_content(post.title) }
    end
    it "should show the post's body" do
      @user.posts.each { |post| expect(page).to have_content(post.text) }
    end
    it "should show the post's first comment" do
      first_comment = @user.posts.first
      expect(page).to have_content(first_comment.text)
    end
    it 'should show how many comments a post has' do
      post = @user.posts.first
      expect(page).to have_content("Comments: #{post.comments_counter}")
    end
    it 'should have button for pagination' do
      expect(page).to have_button('Pagination')
    end
  end
end