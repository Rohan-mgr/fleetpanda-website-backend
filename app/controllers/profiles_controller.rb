class ProfilesController < ApplicationController
  def create
    user = User.find(params[:user_id])
    profile = user.build_profile(profile_params)
    if profile.save
      render json: {message: "User profile created successfully"}, status: :ok
    else
      render json: {message: "Failed to create user profile"}, status: :unprocessable_entity
    end
  end

   def update
    user = User.find(params[:user_id])
    updated_profile = user.profile.update(profile_params)
    if updated_profile
      render json: {message: "User profile updated successfully"}, status: :ok
    else
      render json: {message: "Failed to update user profile"}, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:address, :country, :age, :contact, :dob, :gender)
  end
end