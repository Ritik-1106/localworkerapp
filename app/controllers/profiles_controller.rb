# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_worker_role

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

    @profile = Profile.find_by(user_id: params[:id])

    if @profile.nil?
      redirect_to root_path, alert: "Profile not found."
      return
    end

    # Logic based on the current user's role
    case current_user.role
    when "worker"
      # Workers can only view their own profile
      if current_user.id == @profile.user_id
        render :show
      else
        redirect_to root_path, alert: "You are not authorized to view this profile."
      end

    when "contractor"
      # Contractors can view the worker's profile
      if @profile.user.worker?
        render :show
      else
        redirect_to root_path, alert: "You are not authorized to view this profile."
      end

    when "admin"
      # Admins can view all profiles
      render :show

    else
      # Redirect if the user does not have permission
      redirect_to root_path, alert: "You are not authorized to view this profile."
    end
  end
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
