module Types 
  module Comments
    class CommentResponseType < BaseObject
      field :comments, [Types::Comments::CommentType], null: true
      field :errors, [String], null: true
    end
  end
end