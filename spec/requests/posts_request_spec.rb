require 'rails_helper'

RSpec.describe 'Post', type: :request do
  describe 'GET /index' do
    before :each do
      get '/users/:user_id/posts'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns http status 200' do
      expect(response.status).to eq(200)
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end

    it 'should render placeholder from index method' do
      expect(response.body).to include('<h1>User Posts</h1>')
    end
  end

  describe 'GET /show' do
    before :all do
      user = { name: 'Tan' }
      @user = User.create(user)
      valid_attributes = { author: @user, title: 'Post Title' }
      @post = Post.create! valid_attributes
      get "/users/:user_id/posts/#{@post.id}"
    end

    it 'returns http success' do
      expect(response).to be_successful
    end

    it 'returns http status 200' do
      expect(response.status).to eq(200)
    end

    it 'should render show template' do
      get "/users/:user_id/posts/#{@post.id}"
      expect(response).to render_template(:show)
    end

    it 'should render placeholder from show method' do
      expect(response.body).to include('<h1>Single Post</h1>')
    end
  end
end