module Mutations
  module Users
    class CreateProfile < BaseMutation
      argument :profile_info, Types::InputObjects::ProfileInputType, required: true

      field :profile, Types::Users::ProfileType, null: true
      field :errors, [String], null: true

      def resolve(profile_info: {})
        begin
          profile_service = ::Users::ProfileService.new(profile_info.to_h).execute_create_profile

          if profile_service.success? 
            {
              profile: profile_service.profile,
              errors: []
            }
          end
        end
      rescue StandardError => err
        {
          profile: nil,
          errors: [err.message]
        }
      end
    end
  end
end