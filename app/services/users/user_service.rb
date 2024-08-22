module Users
  class UserService
    attr_accessor :success, :errors

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def success
      @success ||= @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_profile_upload
      begin
        user = User.find(params[:id])
        if user.avatar.attached(profile_params)
          @success = true
          @errors = []
        end
      end
      
      rescue StandardError => err
        @success = false
        @errors << err.message
    end

    def profile_params
      ActionController::Parameters.new(params).permit(:avatar)
    end
  end
end