module Resolvers
  module Users
    class FetchUsers < BaseResolver
      type Types::Users::UsersResponseType, null: true
      argument :organization_id, ID, required: true


      def resolve(organization_id:) 
        begin
          user_service = ::Users::UserService.new({organization_id: organization_id}).execute_fetch_users
          if user_service.success?
            {
              users: user_service.users,
              error: []
            }
          end
        end
        rescue StandardError => err
          {
            users: nil, 
            error: [err.message]
          }
      end
    end
  end
end