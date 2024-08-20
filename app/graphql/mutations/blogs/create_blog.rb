module Mutations
  module Blogs
    class CreateBlog < BaseMutation
      argument :blog_info, Types::InputObjects::BlogInputType, required: true

      field :blog, Types::Blogs::BlogType, null: true
      field :errors, [String], null: true

      def resolve(blog_info: {})
        begin
          blog = Blog.create!(title: blog_info.title, status: blog_info.status, content: blog_info.content, user_id: blog_info.user_id, organization_id: blog_info.organization_id)
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