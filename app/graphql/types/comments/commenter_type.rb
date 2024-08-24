module Types 
  module Comments
    class CommenterType < BaseObject
      field :id, ID, null: false
      field :avatar, String, null: true
      field :email, String, null: false
      field :fullname, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end