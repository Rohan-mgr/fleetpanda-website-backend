module Resolvers
  module Comments
    class GetComments < BaseResolver
      argument :blog_id, ID, required: false 
      argument :user_id, ID, required: false 
      
      type Types::Comments::CommentResponseType, null: true

      def resolve(blog_id: nil, user_id: nil)
        return {comments: [], errors: ["Provide either blogId or userId"]} if blog_id.nil? && user_id.nil?
        begin
          comment_service = ::Comments::CommentService.new({blog_id: blog_id, user_id: user_id}).execute

          if comment_service.success?
            {
              comments: comment_service.comments,
              errors: []
            }
          end
        rescue StandardError => err 
          {
            comments: [],
            errors: [err.message]
          }
        end
      end     
    end
  end
end