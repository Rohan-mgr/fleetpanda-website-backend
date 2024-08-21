module Resolvers
  module Users
    class UserLogin < BaseResolver
      type Types::Users::UserResponseType, null: true
      argument :login_info, Types::InputObjects::UserLoginInputType, required: true


      def resolve(login_info: {}) 
        begin
          session_service = session_service = ::Users::SessionService.new(login_info.to_h).execute

          if session_service.success?
            {
              loggedUser: session_service.loggedUser, 
              token: session_service.token,
              organization: session_service.organization,
            }
          end
        end
        rescue StandardError => err
          {
            loggedUser: nil, 
            errors: [err.message]
          }
      end
    end
  end
end