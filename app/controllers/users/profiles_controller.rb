class Users::ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @user=User.find(@profile.user_id)
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
    redirect_to users_profile_path(@profile.user_id)
  end

  def profile_params
    params.require(:profile).permit(:introduce,:hp_url,:address,:icon_image) 
  end
end
