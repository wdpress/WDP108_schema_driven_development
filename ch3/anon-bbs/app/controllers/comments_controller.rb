class CommentsController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    @comments = post.comments
  end

  def create
    post = Post.find(params[:post_id])

    @comment = post.comments.build(comment_params)

    if @comment.save
      render status: :created
    else
      errors = @comment.errors.full_messages.map { |message| { title: 'invalid param', detail: message } }
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])

    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
