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
      render json: {success: true}
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

  def outlet_images
    outlet_id = params[:outlet_id]
    outlet = Outlet.friendly.find(outlet_id)
    comment_id = params[:comment_id]
    offer_id = params[:offer_id]
    key = 'Outlet-' + outlet.slug + '-images'
    key = (key + '-offer-' + offer_id.to_s) unless offer_id.nil?
    key = (key + '-comment-' + comment_id.to_s) unless comment_id.nil?
    output = CacheService.fetch_key(key)
    #per_page = params[:per_page] || Rails.configuration.x.per_page
    #page = params[:page] || 1
    if output.nil?
      @images = OutletImage.where(:outlet => outlet)
      @images = @images.where(:comment_id => comment_id) unless comment_id.nil?
      @images = @images.where(:offer_id => offer_id) unless offer_id.nil?
      output = Rabl::Renderer.new('user/images/index', @images).render
      CacheService.update_key(key, output)
    end

    #Lets not paginate the images, we can fetch all image urls in once.
    #@images = @images.paginate(:per_page => per_page, :page => page)
    render json:output
  end

end