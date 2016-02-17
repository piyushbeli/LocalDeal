class CommentsController < ApplicationController

  devise_token_auth_group :member, contains: [:user, :vendor, :god]

  before_action :authenticate_member!, only:[:create, :like, :spam, :clear_like, :clear_spam]
  before_action :find_commentable, only: [:create, :index]
  before_action :find_comment, only: [:show, :destroy, :like, :spam, :clear_like, :clear_spam]

  respond_to :json

  #For example it will give you the outlet object for which we are searching the reviews.
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
    if @commentable.slug
      key = 'Outlet-' + @commentable.slug + '-reviews-page-' + page.to_s
    else
      key = 'Outlet-' + @commentable.id.to_s + '-reviews-page-' + page.to_s
    end
    if offer_id
      key = key + '-offer-' + offer_id
    end

    @comments = CacheService.fetch_key(key)
    if @comments.nil?
      if offer_id
        @comments = @commentable.comments.where(:offer_id => offer_id).includes(:comments, :commentator).paginate(:page => page, :per_page => per_page).order("created_at DESC")
      else
        @comments = @commentable.comments.includes(:comments, :commentator).paginate(:page => page, :per_page => per_page).order("created_at DESC")
      end
      @total_comments = @comments.length
      output = Rabl::Renderer.new('comments/index', @comments, :locals => { :total_comments => @comments.length}).render
      CacheService.update_key(key, output)
    else
      render json: @comments
      return
    end

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
      invalidate_all_outlet_comments
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
        invalidate_all_outlet_comments
        render json: {success: true}
      else
        render :json => {errors: ['Some error has occured'], status: 422}
      end
    end
  end

  def invalidate_all_outlet_comments
    #invalidate all the comments key in redis
    if @commentable.slug
      key = '*Outlet-' + @commentable.slug + '-reviews*'
    else
      key = '*Outlet-' + @commentable.id.to_s + '-reviews*'
    end
    CacheService.delete_matched(key)
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