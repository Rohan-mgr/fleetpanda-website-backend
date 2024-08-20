module Types
  module InputObjects
    class BlogInputType < BaseInputObject 
      argument :status, Types::Enums::BlogStatusEnum, required: true
      argument :title, String, required: true
      argument :content, String, required: true
      argument :user_id, ID, required: true
      argument :organization_id, ID, required: true
    end
  end
end