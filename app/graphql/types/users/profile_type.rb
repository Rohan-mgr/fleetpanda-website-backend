# frozen_string_literal: true

module Types
  module Users
    class ProfileType < Types::BaseObject
      field :id, ID, null: false
      field :address, String
      field :country, String
      field :age, Integer
      field :contact, String
      field :dob, GraphQL::Types::ISO8601DateTime
      field :gender, Enums::ProfileGenderEnum 
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :user_id, Integer, null: false
    end
  end
end
