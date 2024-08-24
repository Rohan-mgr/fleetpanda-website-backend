module Users
  class RegistrationService
    attr_reader :params
    attr_accessor :success, :errors

    def initialize(params = {})
      @params = params
      @success = false 
      @errors = []
    end

    def execute
      handle_user_registration
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    def user
      @user || nil
    end

    private 


    def handle_user_registration
      ActiveRecord::Base.transaction do
        @user = User.new(sign_up_params)
        if organization.present?
          @user.save!
          membership(@user.id, organization.id)
          # Membership.create!(user_id: user.id, organization_id: organization.id)
        end
        @success = true
        @errors = []
      end
      
      rescue ActiveRecord::Rollback => err
        @success = false
        @errors << err.message
    end

    def organization 
      organization ||= Organization.find_by(id: params[:organization_id]);
    end

    def membership(user_id, organization_id)
      Membership.create!(user_id: user_id, organization_id: organization_id)
    end

    def sign_up_params
      ActionController::Parameters.new(params).permit(:fullname, :email, :password, :password_confirmation)
    end
  end
end
