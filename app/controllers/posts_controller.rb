class PostsController < ApplicationController
  def index
    @posts = Post.where(status: true)
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
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)

    # リダイレクト処理
    redirect_to post,notice: '編集しました'
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
