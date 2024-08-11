class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(sign_up_params)
    org = Organization.find_by(id: params[:organizationId]);

    if org
    User.transaction do
      if user.save
        Member.create!(user: user, organization: org)
        render json: { message: "User signed up successfully" }, status: :ok
      else
        render json: { message: "User signup failed!"}, status: :unprocessable_entity
      end
    end
    else
      render json: { message: "Organization not found" }, status: :not_found
    end
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: "Error creating membership", errors: e.message }, status: :unprocessable_entity
    end

  private def sign_up_params
    transformed_params = {
      fullname: params[:fullName], 
      email: params[:email], 
      password: params[:password],
      password_confirmation: params[:confirmPassword],
      organization_id: params[:organizationId]
    }
    ActionController::Parameters.new(transformed_params).permit(:fullname, :email, :password, :password_confirmation, :organization_id)
  end
end
