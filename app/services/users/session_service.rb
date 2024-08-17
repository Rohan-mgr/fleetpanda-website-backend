module Users
  class SessionService
    attr_reader :params
    attr_accessor :success, :errors, :token, :organization, :loggedUser

    def initialize(params = {})
      @params = params
      @success = false  
      @errors = []
      @token = nil
      @organization = nil 
      @loggedUser = nil
    end

    def execute
      handle_user_session
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private 

    def handle_user_session
      ActiveRecord::Base.transaction do 
        org = Organization.find_by(id: params[:organization_id])
        @errors << "Organization not found for this user" if org.nil?
        user = org.users.find_by(email: params[:email])
        @errors << "User not found in this organization" if user.nil?

        if user.valid_password?(params[:password])
          @token = Digest::SHA1.hexdigest([Time.now, rand].join)
          @loggedUser = user
          @organization = org
          @success = true 
          @errors = []
        else 
          @success = false
          @errors << "Invalid email or password"
        end
      end

      rescue ActiveRecord::Rollback => err
        @success = false
        @errors = err.message
    end

    def def login_params 
      params.require(:session).permit(:email, :password, :organization_id)
    end
  end
end