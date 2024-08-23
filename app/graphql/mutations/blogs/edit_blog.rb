module Mutations
  module Blogs
    class EditBlog < BaseMutation
      argument :blog_info, Types::InputObjects::BlogInputType, required: true
      argument :blog_id, ID, required: true

      field :blog, Types::Blogs::BlogType, null: true
      field :errors, [String], null: true

      def resolve(blog_id:,blog_info:)
         begin
          blog = Blog.find(blog_id)
          if blog.update!(blog_info.to_h)
            { 
              blog: blog, 
              errors: []
            }
          end
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