class CommentsController < ApplicationController
include UserResourceController
=begin
  devise_group :member, contains: [:user, :vendor]
  before_filter :authenticate_member!
=end

  before_action :find_commentable

  respond_to :json

  #For example it will give you the deal object for which we are searching the reviews.
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @commentable = $1.classify.constantize.find(value)
        if @commentable.nil?
          render json: {errors: ["Could not find the deal with this id"]}, status: 422
        end
      end
    end
  end

  def index
    per_page = params[:perPage] || 10
    page = params[:page] || 1
    @reviews = @commentable.comments.paginate(:page => page, :per_page => per_page).order("created_at DESC")
    render 'reviews/index'
  end

  def show
    render json: @commentable.comments.find(params[:id])
  end

  def create
    comment = Comment.new(comment_params.merge(:commentator => current_member, :commentable => @commentable))
    if comment.save
      render json: comment
    else
      render json: {errors: comment.errors.full_messages}, status: 422
    end

    def destroy

    end

  end

  def comment_params
    params.require(:comment).permit(:body, :title)
  end

end