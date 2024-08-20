# frozen_string_literal: true

module Types
  module Comments
    class CommentType < Types::BaseObject
      field :id, ID, null: false
      field :body, String, null: false
      field :commentable_type, String, null: false
      field :commentable_id, Integer, null: false
      field :commenter, Types::Comments::CommenterType, null: true  
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :created_by, Integer, null: false
    end
  end
end
