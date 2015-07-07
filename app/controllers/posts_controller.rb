class PostsController < ApplicationController
  #Require user to be logged in for any actions except for show and index.
  def show
    @post = Post.find(params[:id])
    @post.created_at
    @title = @post.title + ' - zack6849'
  end

  def new
    authorize
    @post = Post.new
  end

  def edit
    authorize
    @post = Post.find(params[:id])
    @title = 'Editing post "' + @post.title.truncate_words(2) + '"'
  end

  def create
    :authorize
    @post = Post.new(params.require(:post).permit(:title, :text, :date))
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    authorize
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    authorize
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/'
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :date)
  end
end
