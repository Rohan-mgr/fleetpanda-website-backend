module Mutations
  module Users
    class CreateUser < BaseMutation
      argument :user_info, Types::InputObjects::UserRegistrationInputType, required: true

      field :user, Types::Users::UserType, null: true
      field :errors, [String], null: true

      def resolve(user_info: {})
        begin
          registration_service = ::Users::RegistrationService.new(user_info.to_h).execute
          if registration_service.success?
            {
              user: registration_service.user,
              errors: []
            }
          end
        end
        rescue StandardError => err
          {
            user: nil,
            errors: [err.message]
          }
      end
    end
  end
end