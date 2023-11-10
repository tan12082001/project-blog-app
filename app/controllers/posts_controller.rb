class PostsController < ApplicationController
  load_and_authorize_resource
  layout 'boilerplate'
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).order(id: :asc)
    @posts = @posts.paginate(page: params[:page], per_page: 2)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.decrement!(:comments_counter)
    @comment.destroy!
    flash[:success] = 'Comment deleted.'
    redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:success] = 'Post added Successfully!'
      redirect_to user_posts_url
    else
      flash.now[:error] = 'Error: Post could not be saved!'
      render :new, locals: { post: @post }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.author.decrement!(:posts_counter)
    @post.destroy!
    flash[:success] = 'Post Deleted!'
    redirect_to user_posts_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
