class CommentsController < ApplicationController
  before_action :deadline_post_deleate, only: [:create]

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @comment.post_images.build
  end

  def create
    @post = Post.find(params[:post_id])
    today=Date.today
    # もし募集期間が過ぎていたらリダイレクト
    if @post.deadline < today
      redirect_to posts_path,notice: 'この投稿はコメント募集終了しています。'
    else
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.post_id=@post.id
      if @comment.save
        redirect_to post_path(@post),notice: 'コメントしました'
      else
        render :new
      end
    end

  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    if @comment.update(comment_params)
      # リダイレクト処理
      redirect_to post_path(@post),notice: '編集しました'
    else
      render :edit
    end
  end

  def delete
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(params[:post_id])
    @comment.update(delete_flag: true)
    redirect_to post_path(@post),notice: '編集しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:body,post_images_images: []) 
  end
end
