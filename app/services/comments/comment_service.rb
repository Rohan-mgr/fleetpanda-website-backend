
module Comments
  class CommentService

    attr_reader :params
    attr_accessor :success, :errors

    def initialize(params = {})
      @params = params
      @success = false 
      @errors = []
    end

    def execute
      get_comments
      self
    end
    
    def execute_create_comment
      create_comments
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    def comments 
      @comments || []
    end

    private 

    def get_comments
      ActiveRecord::Base.transaction do
        comments = if params[:blog_id]
                     Blog.find(params[:blog_id]).comments.reverse()
                   else
                     User.find(params[:user_id]).comments.reverse()
                   end

        
        @comments = comments.map do |comment| 
          user = User.find(comment.created_by)
          commenter = user.as_json.merge(avatar: user.avatar.attached? ?  Rails.application.routes.url_helpers.rails_representation_url(user.avatar, only_path: true) : nil)
          comment.as_json.merge(commenter: commenter)
        end

        @success = true
        @errors = []
      end

        rescue ActiveRecord::Rollback => err
          @success = false
          @errors << err.message
    end

    def create_comments
      ActiveRecord::Base.transaction do 
        commentable = if params[:blog_id]
                        Blog.find(params[:blog_id])
                      else
                        User.find(params[:user_id])
                      end

        comment = Comment.new(comments_params.merge({created_by: params[:commenterId],commentable: commentable}))
        comment.save!

        @success = true
        @error = []
      end

      rescue ActiveRecord::RecordInvalid => err
        @success = false
        @errors << err.message
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      
    end

    def comments_params 
      params.require(:comment).permit(:body)
    end

  end
end