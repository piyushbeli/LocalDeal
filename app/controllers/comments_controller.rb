class CommentsController < ApplicationController
  include UserResourceController

  def create
    post = Post.find(params[:post_id])
    render json: post.comments.create(comment_params.merge(user_id: current_user.id))
  end

  def show
    respond_with Comment.find(params[:id])
  end

  def upvotes
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.upvotes = comment.upvotes + 1
    comment.save
    respond_with comment
  end

  def comment_params
    params[:comment].permit(:body)
  end
end
