class BlogsController < ApplicationController
  def index
    organization = Organization.find(params[:organization_id])
    blogs = organization.blogs
    # blogs = Blog.order('created_at DESC')
    render json: blogs
  end

  def show
    blog = Blog.find(params[:id])
    render json: {blog: blog, message: "Blog fetched successfully"}, status: :ok
  end

  def create
    blog = Blog.create(premitted_blog_params)

    if blog.save
      render json: {blog: blog, message: "Blog created successfully"}, status: :ok
    else
      render json: {message: "Blog creation failed"}, status: :unprocessable_entity
    end
  end

  def update
    blog = Blog.find(params[:id])
    if blog.update(premitted_blog_params)
      render json: {message: "Blog updated successfully"}, status: :ok
    else
      render json: {message: "Failed to updated blog"}, status: :internal_server_error
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    render json: {message: "Blog deleted successfully"}, status: :ok
  end

  private 
  
  def premitted_blog_params 
    params.require(:blog).permit(:title, :content, :status, :organization_id, :user_id)
  end
end
