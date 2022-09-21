class PostsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable

  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
    post = Post.find(params[:id])

    post.update!(post_params)

    render json: post
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def render_not_found
    render json: {error: 'Author not found'}, status: :not_found
  end

  def render_unprocessable(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end

end
