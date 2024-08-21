module Types
  module InputObjects
    class CommentInputType < BaseInputObject
      argument :body, String, required: true
      argument :created_by, ID, required: true
    end
  end
end