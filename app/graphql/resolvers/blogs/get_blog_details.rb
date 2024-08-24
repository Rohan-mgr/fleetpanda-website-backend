module Resolvers
  module Blogs
    class GetBlogDetails < BaseResolver
      type Types::Blogs::BlogType, null: true
      argument :blog_id, ID, required: true

      def resolve(blog_id:)
        Blog.find(blog_id)
      end
    end
  end
end