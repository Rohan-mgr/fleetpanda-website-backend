# frozen_string_literal: true

module Types
  module Users
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :avatar, String, null: true
      field :fullname, String, null: false
      field :email, String, null: false
      field :encrypted_password, String, null: false
      field :reset_password_token, String
      field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime
      field :remember_created_at, GraphQL::Types::ISO8601DateTime
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

      def avatar 
        object.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true) : nil
      end
    end
  end
end
