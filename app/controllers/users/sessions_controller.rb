class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    org = Organization.find_by(id: params[:organization_id])

    if org.nil?
      return render json: { message: "Organization not found for this user" }
    end

    user = org.users.find_by(email: params[:email])

    if user.nil?
      return render json: { message: "User not found in this organization" }, status: :unauthorized
    end

    if user.valid_password?(params[:password])
      token = Digest::SHA1.hexdigest([Time.now, rand].join)
      render json: { token: token,  message: "Login successful", loggedUser: user, organization: org }, status: :ok
    else
      render json: { message: "Invalid email or password" }, status: :unauthorized
    end
end

  private def login_params 
    params.require(:session).permit(:email, :password, :organization_id)
  end
end
