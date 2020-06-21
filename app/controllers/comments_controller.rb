class CommentsController < ApplicationController
  def index
   # 不要？
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @comment.post_images.build
    #binding.pry
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @post = Post.find(params[:post_id])
    @comment.post_id=@post.id

    #binding.pry
    if @comment.save
      redirect_to post_path(@post),notice: 'コメントしました'
    else
      render :new
    end

  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    comment = Comment.find(params[:id])
    post = Post.find(params[:post_id])
    if comment.update(comment_params)
      # リダイレクト処理
      redirect_to post_path(post),notice: '編集しました'
    else
      render :new
    end

    
  end

  def show
    # 不要？
  end

  def destroy
    # 「このコメントは削除されました」を表示
  end

  private

  def comment_params
    params.require(:comment).permit(:body,post_images_images: []) 
  end
end
