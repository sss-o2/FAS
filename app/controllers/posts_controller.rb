class PostsController < ApplicationController
  def index
    #@posts = Post.all
    @posts = Post.search(params[:search],params[:status])
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def new
    @post = Post.new
    @post.post_images.build
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

  def search
    @posts = Post.search(params[:search])
  end

  def select_best_comment
    @best_comment=Post.select_best_comment(params[:post][:best_comment])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body,:status,:deadline,:tag_list,post_images_images: []) 
    #tag_list を追加
  end
end
