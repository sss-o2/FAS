class Users::ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @user=User.find(@profile.user_id)

    @best_comments=Comment.where(best_flag: true).where(user_id: @user.id)
    # いいねした数用
    @to_favorites=Favorite.where(user_id: @user.id)

    # いいねされた数用 後で消すかも
    user_comments=Comment.where(user_id: @user.id)
    @count=0
    user_comments.each do |comment|
      @count+= Favorite.where(comment_id: comment.id).count
    end

    @user_posts=Post.where(user_id: @user.id).page(params[:page]).per(5)
    @user_posts_count=Post.where(user_id: @user.id).count
    
    @user_favorit_comments=@user.favorite_comments.includes(:user).page(params[:page]).per(5)
    @user_favorit_comments_count=@user.favorite_comments.includes(:user).count
    
    @user_best_comments=@user.comments.where(best_flag: true).page(params[:page]).per(5)
    @user_best_comments_count=@user.comments.where(best_flag: true).count

  end

  def edit
    @profile = Profile.find(params[:id])
    @user=User.find(@profile.user_id)
    # binding.pry
  end

  def update
    profile = Profile.find(params[:id])
    if profile.update(profile_params)
      redirect_to action: :show,notice: '編集しました'
    else
      render :show
    end
  end

  def profile_params
    params.require(:profile).permit(:introduce,:hp_url,:address,:icon_image) 
  end

end
