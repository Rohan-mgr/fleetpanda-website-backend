module Mutations
  module Comments
    class CreateComment < BaseMutation
      argument :comment_info, Types::InputObjects::CommentInputType, required: true
      argument :blog_id, ID, required: false
      argument :user_id, ID, required: false

      field :comment, Types::Comments::CommentType, null: true
      field :errors, [String], null: true

      def resolve(blog_id: nil, user_id: nil, comment_info: {})
        begin
          comment_service = ::Comments::CommentService.new({blog_id: blog_id, user_id: user_id, comment_info: comment_info.to_h}).execute_create_comment

          if comment_service.success? 
            {
              comment: comment_service.comment,
              errors: []
            }
          end
        rescue StandardError => err
          {
            comment: nil,
            errors: [err.message]
          }
        end
      end
    end
  end
end