module Users
  class UserService
    attr_reader :params
    attr_accessor :success, :errors, :users

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_fetch_users
      handle_users_fetch
      self
    end

    def success?
      @success ||= @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_users_fetch
      begin
        ActiveRecord::Base.transaction do 
          organization = Organization.find(params[:organization_id])
          if organization.present?
            @users = organization.users
            @users = @users.map do |user|
              user.as_json.merge(avatar: user.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(user.avatar, only_path: true): nil)
            end
            
            @success = true
            @errors = []
          end
        end
      end
      
      rescue ActiveRecord::Rollback => err
        @success = false
        @errors << err.message
    end

    def profile_params
      ActionController::Parameters.new(params).permit(:avatar)
    end
  end
end