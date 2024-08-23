module Types
  module Users
    class UserDetailsResponseType < BaseObject
      field :user, Types::Users::UserType, null: true
      field :errors, [String], null: true
    end
  end
end