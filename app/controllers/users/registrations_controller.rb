class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def new
    super
  end

  def create
    registration_service = ::Users::RegistrationService.new(params).execute
    # debugger
    if registration_service.success?
      render json: { message: "User signed up successfully" }, status: :ok
    else
      render json: { message: "User signup failed!"}, status: :unprocessable_entity
    end 
  end
end
