module Mutations
  module Blogs
    class DeleteBlog < BaseMutation
      argument :blog_id, ID, required: true

      field :message, String, null: false
      field :error, String, null: true

      def resolve(blog_id:) 
        begin
          blog = Blog.find(blog_id)
          blog.destroy
          {
            message: "Blog deleted successfully", 
            error: nil
          }
        end
        rescue StandardError => err
          {
            message: "Failed to delete blog",
            error: err.message
          }
      end
    end
  end
end