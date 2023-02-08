require 'rails_helper'

RSpec.describe 'user_posts/#index', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe',
                        photo: 'https://dummypic.jpg',
                        bio: 'Long text describing my bio')
    @first_post = Post.create(author: @user, title: 'Post 1', text: 'This is my first post')
    @second_post = Post.create(author: @user, title: 'post 2',
                               text: 'This is my second post')

    @comment1 = Comment.create(author: @user, post: @second_post, text: 'Comment 1')
    @comment2 = Comment.create(author: @user, post: @second_post, text: 'Comment 2')
    @comment3 = Comment.create(author: @user, post: @second_post, text: 'Spend the credits wisely :|')

    visit user_path(@user)

    click_link 'See all posts'
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
    it 'should show how many likes a post has' do
      post = @user.posts.first
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end
    it 'redirects to post show page when a post is clicked' do
      find("a[id='show-btn-#{@first_post.id}']").click
      expect(current_path).to match user_post_path(user_id: @user.id, id: @first_post.id)
    end
    it 'should have button for pagination' do
      expect(page).to have_button('Pagination')
    end
  end
end
