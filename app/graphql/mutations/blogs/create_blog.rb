module Mutations
  module Blogs
    class CreateBlog < BaseMutation
      argument :blog_info, Types::InputObjects::BlogInputType, required: true

      field :blog, Types::Blogs::BlogType, null: true
      field :errors, [String], null: true

      def resolve(blog_info: {})
        begin
          blog = Blog.create!(blog_info.to_h)
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