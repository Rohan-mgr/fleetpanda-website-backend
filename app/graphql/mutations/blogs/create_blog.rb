module Mutations
  module Blogs
    class CreateBlog < BaseMutation
      argument :status, Types::Enums::BlogStatusEnum, required: true
      argument :title, String, required: true
      argument :content, String, required: true
      argument :user_id, ID, required: true
      argument :organization_id, ID, required: true

      field :blog, Types::Blogs::BlogType, null: true
      field :errors, [String], null: true

      def resolve(status:, title:, content:, user_id:, organization_id:)
        begin
          blog = Blog.create!(title: title, status: status, content: content, user_id: user_id, organization_id: organization_id)
          {
            blog: blog, 
            errors: []
          }
        rescue StandardError => err
          {
            blog: nil, 
            errors: [err.message]
          }
        end
      end
    end
  end
end