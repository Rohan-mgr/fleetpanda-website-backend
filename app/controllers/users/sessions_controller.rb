class Users::SessionsController < Devise::SessionsController
  respond_to :json
  def new
    super
  end

  def create
    session_service = ::Users::SessionService.new(params).execute
    if session_service.success? 
      render json: {token: session_service.token, message: "Login successfull", loggedUser: session_service.loggedUser, organization: session_service.organization}, status: :ok
    else  
      render json: {message: session_service.errors}, status: :unprocessable_entity
    end
  end
  
end
