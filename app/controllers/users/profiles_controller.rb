class Users::ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @user=User.find(@profile.user_id)

    @best_comments=Comment.where(best_flag: true).where(user_id: @user.id)
    # いいねした数用
    @to_favorites=Favorite.where(user_id: @user.id)

    user_comments=Comment.where(user_id: @user.id)
    @count=0
    user_comments.each do |comment|
      @count+= Favorite.where(comment_id: comment.id).count
    end

    @user_posts=Post.where(user_id: @user.id).page(params[:page]).per(5)
    #binding.pry
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
