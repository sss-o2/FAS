class Users::ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @user=User.find(@profile.user_id)
  end

  def edit
    @profile = Profile.find(params[:id])
    @user=User.find(@profile.user_id)
    binding.pry
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
