class ImagesController < ApplicationController
  include CommonResourceController

  def upload
    url = params[:url]
    outlet_id = params[:outlet_id]
    outlet = Outlet.friendly.find(outlet_id)
    #We would also like to track if an image is uploaded against a comment or/and an offer. But it is not necessary that
    #it must be against any of those, only mandatory entity is outlet.
    comment_id = params[:comment_id]
    offer_id = params[:offer_id]
    caption = params[:caption]

    if comment_id
      comment = Comment.find(comment_id)
      if comment.commentator != current_member
        render json: {errors: ['You can not upload an image for others comment'], sttaus: 401}
        return
      end
      if comment.commentable != outlet
        render json: {errors: ['This comment does not belong to the outlet you provided'], sttaus: 401}
        return
      end
    end
    if offer_id
      offer = Offer.find(offer_id)
      if !offer.deal.outlets.to_a.include?(outlet)
        render json: {errors: ['Offer you provided does not belong to the outlet'], status: 422}
        return
      end
    end

    outlet_image = OutletImage.new(url: url, outlet: outlet, uploader: current_member, comment: comment, offer: offer, caption: caption)
    if outlet_image.save
      render json: outlet_image
    else
      render json: {errors: outlet_image.errors.full_messages, status: 422}
    end
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


  def member_images
    @images = current_member.outlet_images
    outlet_id = params[:outlet_id]
    #In case of vendor outlet id will also come.
    if outlet_id
      outlet = Outlet.friendly.find(params[:outlet_id])
      @images = @images.where(outlet: outlet) unless outlet.nil?
    end
    render 'images/index.rabl'
  end

end