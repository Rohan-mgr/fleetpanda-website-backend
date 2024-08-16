class UsersController < ApplicationController
  def index
    ActiveRecord::Base.transaction do 
      organization = Organization.find(params[:organization_id])
      if organization.present?
        users = organization.users
        users = users.map do |user|
          user.as_json.merge(avatar: user.avatar.attached? ? url_for(user.avatar): nil)
        end
        render json: {users: users, message: "Users fetched successfully"}, status: :ok
      end
    end

    rescue ActiveRecord::Rollback => err
      render json: {message: err.message}, status: :unprocessable_entity
  end

  def info
    user = User.find(params[:id])
    user_profile = Profile.find_by(user_id: user.id)
    if user.present?
      complete_profile = user.as_json.merge(profile: user_profile, avatar: user.avatar.attached? ? url_for(user.avatar): nil)
      render json: {userDetails: complete_profile, message: "User Details fetched successfully"}, status: :ok
    else 
      render json: {message: "Failed to fetched user details"}, status: :unprocessable_entity
    end
  end

  def upload_profile
    user = User.find(params[:id])
    if user.avatar.attach(params[:avatar])
      render json: {message: "Profile image uploaded successfully"}, status: :ok
    else 
      render json: {message: "Failed to upload profile image"}, status: :unprocessable_entity
    end
  end
end