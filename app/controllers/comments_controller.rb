class CommentsController < ApplicationController
  include CommonResourceController

  before_action :authenticate_member!, only:[:create, :like, :spam, :clear_like, :clear_spam]
  before_action :find_commentable, only: [:create, :index]
  before_action :find_comment, only: [:show, :destroy, :like, :spam, :clear_like, :clear_spam]

  respond_to :json

  #For example it will give you the deal object for which we are searching the reviews.
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @commentable = $1.classify.constantize.find_by_id(value)
        #While posting the comment on a deal slug id will be there, so lets try for that too before rendering the error
        if @commentable.nil?
          @commentable = $1.classify.constantize.friendly.find(value)
        end
        if @commentable.nil?
          render json: {errors: ['Could not find the '+ $1.classify.constantize+ 'with this id']}, status: 422
        end
      end
    end
  end

  def find_comment
    @comment = Comment.find_by_id(params[:comment_id])
    if @comment.nil?
      render :json => {errors: ['Some error has occured'], status: 422}
    end
  end

  def index
    per_page = params[:per_page] || Rails.configuration.x.per_page
    page = params[:page] || 1
    offer_id = params[:offer]
    @comments = @commentable.comments.where(offer_id: offer_id).paginate(:page => page, :per_page => per_page).order("created_at DESC")
    render 'comments/index'
  end

  def show
    render 'comments/show'
  end

  def create
    comment = Comment.new(comment_params.merge(:commentator => current_member, :commentable => @commentable))
    #Can not keep the params name offer_id otherwise commentable method will get confused
    offer_id = params[:offer]
    if offer_id
      offer = Offer.find(offer_id)
      comment.offer = offer
    end
    if comment.save
      render json: comment
    else
      render json: {errors: comment.errors.full_messages}, status: 422
    end
  end

  def destroy
    if @comment.commentator != !current_member
      render :json => {errors: ['You are not the owner of this comment'], status: 401}
    else
      if @comment.delete
        render json: {success: true}
      else
        render :json => {errors: ['Some error has occured'], status: 422}
      end
    end
  end

  def like
    if current_member.mark_as_liked  @comment
      render json: {success: true}
    else
      render json:{errors: ['Some error occurred']}, status: 422
    end
  end

  def clear_like
    if current_member.remove_mark :like,  @comment
      render json: {success: true}
    else
      render json:{errors: ['Some error occurred']}, status: 422
    end
  end

  def spam
    if current_member.mark_as_spam  @comment
      render json: {success: true}
    else
      render json:{errors: ['Some error occurred']}, status: 422
    end
  end

  def clear_spam
    if current_member.remove_mark :spam,  @comment
      render json: {success: true}
    else
      render json:{errors: ['Some error occurred']}, status: 422
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :title)
  end

end