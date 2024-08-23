module Mutations
  module Users
    class UploadAvatar < BaseMutation
      argument :avatar_info, Types::InputObjects::AvatarInputType, required: true

      field :avatar_url, String, null: true
      field :errors, [String], null: true

      def resolve(avatar_info: {})
        begin
          user = User.find(avatar_info[:user_id])
          user.attach_file!(avatar_info[:avatar], :avatar)
          {
            avatar_url: Rails.application.routes.url_helpers.rails_blob_url(user.avatar, only_path: true),
            errors: []
          }
        end
        rescue StandardError => err
          {
            avatar_url: nil,
            error: [err.message]
          }
      end
    end
  end
end