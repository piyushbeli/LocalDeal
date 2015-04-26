class PostsController < ApplicationController
  include UserResourceController
  before_action :find_post, only: [:show, :update]
  before_action :verify_ownership, only: [:update]


  def index
    respond_with Post.all
  end

  def show
    render json: @post
  end

  def create
    post = Post.new(post_params.merge(user_id: current_user.id))
    post.upvotes = 0
    if post.save
      respond_with post
    end
  end

  def update
    if @post.update(post_params)
      render json: {success: true}
    end
  end

  def upvote
    post = Post.find(params[:id])
    post.increment!(:upvotes)
    render json: post
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def verify_ownership
    if current_user.id != @post.user.id
      flash[:error] = "Not authorized"
      render json: {error: "Not authorized"}, status: 401
    end
  end

  def post_params
    params.require(:post).permit(:link, :title)
  end
end
