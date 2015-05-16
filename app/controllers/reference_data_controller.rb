class ReferenceDataController < ApplicationController
  def categories
    render json: Category.all
  end

  def sub_categories
    render json: Subcategory.where(:category_id => params[:category_id])
  end

  def offer_types
    render json: OfferType.all
  end
end