# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_worker_role

  def new
    # Redirect to show profile if it already exists
    if current_user.profile
      redirect_to profile_path
    else
      @profile = current_user.build_profile
    end
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path, notice: "Profile successfully created!"
    else
      render :new
    end
  end

  def show
    # Show the worker's profile
    @profile = current_user.profile
  end
  def edit
    @profile = current_user.profile
  end

  def update
    if current_user.profile.update(profile_params)
      redirect_to profile_path, notice: "Profile successfully updated!"
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:age, :graduation, :postgraduation, :graduation_year, :postgraduation_year, :skills, :country, :aadhar_no, :experience)
  end

  def ensure_worker_role
    unless current_user.role == "worker"
      redirect_to root_path, alert: "Only workers can access this page."
    end
  end
end
