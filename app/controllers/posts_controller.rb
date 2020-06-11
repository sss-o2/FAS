class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    #binding.pry
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path,notice: '投稿しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body,:image,:status,:deadline,:tag_list) 
    #tag_list を追加
  end
end
