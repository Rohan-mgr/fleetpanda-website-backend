module Types
  module Users
    class SessionResponseType < BaseObject
      field :loggedUser, Types::Users::UserType, null: false
      field :token, String, null: false
      field :organization, Types::Organizations::OrganizationType, null: false
      field :errors, [String], null: true
    end
  end
end