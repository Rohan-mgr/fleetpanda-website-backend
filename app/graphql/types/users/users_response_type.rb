module Types
  module Users
    class UsersResponseType < BaseObject
      field :users, [Types::Users::UserType], null: true
      field :errors, [String], null: true
    end
  end
end