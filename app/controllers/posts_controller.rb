class PostsController < ApplicationController
  def index
    @posts = Post.where(status: true)
    @post_pasts = Post.where(status: false)
  end

  def new
    @post = Post.new
    @post.post_images.build
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
    if post.update(post_params)
       redirect_to post,notice: '編集しました'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def destroy
    # 不要な気がする。statusで削除するやん
  end

  private

  def post_params
    params.require(:post).permit(:title, :body,:status,:deadline,:tag_list,post_images_images: []) 
    #tag_list を追加
  end
end
