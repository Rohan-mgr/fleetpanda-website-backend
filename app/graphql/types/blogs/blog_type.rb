# frozen_string_literal: true
module Types
  module Blogs
    class BlogType < Types::BaseObject
      field :id, ID, null: false
      field :title, String
      field :content, String
      field :status, Types::Enums::BlogStatusEnum, null: false
      # field :status, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :organization_id, Integer, null: false
      field :user_id, Integer, null: false
    end
  end
end

# Types::Enums::BlogStatusEnum