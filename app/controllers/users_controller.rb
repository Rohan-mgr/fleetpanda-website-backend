class UsersController < ApplicationController
  def index
    ActiveRecord::Base.transaction do 
      organization = Organization.find(params[:organization_id])
      if organization.present?
        users = organization.users
        render json: {users: users, message: "Users fetched successfully"}, status: :ok
      end
    end

    rescue ActiveRecord::Rollback => err
      render json: {message: err.message}, status: :unprocessable_entity
  end

  def info
    user_info = User.find(params[:id])
    user_profile = Profile.find_by(user_id: user_info.id)
    if user_info.present?
      complete_profile = user_info.as_json.merge(profile: user_profile)
      render json: {userDetails: complete_profile, message: "User Details fetched successfully"}, status: :ok
    else 
      render json: {message: "Failed to fetched user details"}, status: :unprocessable_entity
    end
  end
end