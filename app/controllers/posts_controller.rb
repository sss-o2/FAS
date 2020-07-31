class PostsController < ApplicationController
  before_action :deadline_post_deleate, only: [:index]
  before_action :authenticate_user!, only: [:new,:edit]

  def index
    @posts = Post.search(params[:search],params[:status]).order('created_at DESC').page(params[:page]).per(6)
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").order('created_at DESC').page(params[:page]).per(6)
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
    @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to @post,notice: '編集しました'
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path,notice: '削除しました'
  end

  def search
    @posts = Post.search(params[:search])
  end

  def select_best_comment
    @best_comment=Post.select_best_comment(
      params[:post][:best_comment],
      params[:post_id]
    )
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body,:status,:deadline,:tag_list,post_images_images: []) 
  end
end
