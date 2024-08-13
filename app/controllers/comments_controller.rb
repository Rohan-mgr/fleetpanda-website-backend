class CommentsController < ApplicationController
  def index
    blog = Blog.find(params[:blog_id])
    comments = blog.comments
    render json: {comments: comments,message: "comments fetched successfulyy"}, status: :ok
  end

  private

  def comments_params 
    params.require(:comment).permit(:commenter, :body)
  end
end