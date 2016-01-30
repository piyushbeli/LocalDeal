class UploadImageController < ApplicationController
  include CommonResourceController

  def upload
    url = params[:url]
    outlet_id = params[:outlet_id]
    outlet = Outlet.friendly.find(outlet_id)
    #We would also like to track if an image is uploaded against a comment. But it is not necessary that
    #it must be against a comment.
    comment_id = params[:comment_id]
    comment = Comment.find(comment_id)
    if comment.commentator != current_member
      render json: {errors: ['You can not upload an image for others comment'], sttaus: 401}
      return
    end
    if comment.commentable != outlet
      render json: {errors: ['This comment does not belong to the outlet you provided'], sttaus: 401}
      return
    end
    outlet_image = OutletImage.new(url: url, outlet: outlet, uploader: current_member, comment_id: comment_id)
    if outlet_image.save
      render json: {success: true}
    else
      render json: {errors: outlet_image.errors.full_messages, status: 422}
    end
    rescue ActiveRecord::RecordNotFound => e
      render :json=> {errors: [e.message], status: 404}
  end

  def delete
    image_id = params[:image_id]
    outlet_image = OutletImage.find(image_id)
    rescue ActiveRecord::RecordNotFound => e
      render :json=> {errors: [e.message], status: 404}
      return;

    if outlet_image.uploader != current_member
      render json: {errors: ['You are not the owner of this image'], sttaus: 401}
    else
      if outlet_image.delete
        render json: {success: true}
      else
        render json: {errors: outlet_image.erros.full_messages, status: 422}
      end
    end
  end

end