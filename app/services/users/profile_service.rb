module Users
  class ProfileService
    attr_reader :params
    attr_accessor :success, :errors, :profile

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
      @profile = nil
    end

    def execute_create_profile
      handle_create_profile
      self
    end

    def execute_update_profile
      handle_update_profile
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private 

    def handle_create_profile
      begin
        user = User.find(params[:user_id])
        @profile = user.build_profile(profile_params)
        if @profile.save
          @success = true
          @errors = []
        else
          @success = false
          @errors << "Failed to create user profile"
        end
      end
    rescue StandardError => err
      @success = false
      @errors << err.message
    end

     def handle_update_profile
      begin
        user = User.find(params[:user_id])
        updated_profile = user.profile.update(profile_params)
        if updated_profile
          @profile = user.profile
          @success = true
          @errors = []
        else
          @success = false
          @errors << "Failed to update user profile"
        end
      end
    rescue StandardError => err
      @success = false
      @errors << err.message
    end

    def profile_params
      ActionController::Parameters.new(params).permit(:address, :country, :age, :contact, :dob, :gender)  
    end
    
  end
end

  # def update
  #   user = User.find(params[:user_id])
  #   updated_profile = user.profile.update(profile_params)
  #   if updated_profile
  #     render json: {message: "User profile updated successfully"}, status: :ok
  #   else
  #     render json: {message: "Failed to update user profile"}, status: :unprocessable_entity
  #   end
  # end