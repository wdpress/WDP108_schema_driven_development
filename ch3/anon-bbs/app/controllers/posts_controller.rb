class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render status: :created
    else
      errors = @post.errors.full_messages.map { |message| { title: 'invalid param', detail: message } }
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      render action: :show
    else
      errors = @post.errors.full_messages.map { |message| { title: 'invalid param', detail: message } }
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy!
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
