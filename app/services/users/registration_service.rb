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

    private 


    def handle_user_registration
      ActiveRecord::Base.transaction do
        user = User.new(sign_up_params)
        if organization.present?
          user.save!
          membership(user.id, organization.id)
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
      organization ||= Organization.find_by(id: params[:organizationId]);
    end

    def membership(user_id, organization_id)
      Membership.create!(user_id: user_id, organization_id: organization_id)
    end

    def sign_up_params
      transformed_params = {
        fullname: params[:fullName], 
        email: params[:email], 
        password: params[:password],
        password_confirmation: params[:confirmPassword]
      }
      ActionController::Parameters.new(transformed_params).permit(:fullname, :email, :password, :password_confirmation)
    end
  end
end
