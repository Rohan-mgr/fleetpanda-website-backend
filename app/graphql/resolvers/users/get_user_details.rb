module Resolvers
  module Users
    class GetUserDetails < BaseResolver
      type Types::Users::UserDetailsResponseType, null: true
      argument :user_id, ID, required: true

      def resolve(user_id:)
        begin
          user = User.find(user_id)
          user_profile = Profile.find_by(user_id: user.id)
          if user.present?
            complete_profile = user.as_json.merge(profile: user_profile, avatar: user.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(user.avatar, only_path: true): nil)
            {
              user: complete_profile, 
              errors: nil
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