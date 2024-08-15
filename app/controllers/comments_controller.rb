class CommentsController < ApplicationController
  def index
    comment_service = ::Comments::CommentService.new(params).execute

    if comment_service.success?
      render json: {comments: comment_service.comments, message: "comments fetched successfulyy"}, status: :ok
    else
      render json: {message: comment_service.errors}, status: :unprocessable_entity
    end
  end

  def create
    comment_service = ::Comments::CommentService.new(params).execute_create_comment

    if comment_service.success? 
      render json: {message: "Comment posted successfully"}, status: :ok
    else 
      render json: {message: comment_service.errors}, status: :unprocessable_entity
    end
  end

end