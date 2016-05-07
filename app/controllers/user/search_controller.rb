class User::SearchController < ApplicationController
  def search
    if params[:q].nil?
      render :json => x[]
    else
      outlets = Outlet.search params[:q], limit: 10, fields: [{name: :text_middle}]
      outlets = outlets.map do |outlet|
        {slug: outlet['slug'], type: 'Outlet', name: outlet['name'], location: (outlet['street'] + ', ' + outlet['city'])}
      end

      offers = Offer.search params[:q], limit: 10, fields: [{what_you_get: :text_middle}]
      offers = offers.map do |offer|
        {slug: offer['slug'], id: offer['id'], offered_price: offer['offered_price'],actual_price: offer['actual_price'], discount: offer['discount'],
         type: 'Offer', name: offer['what_you_get']}
      end
      render :json=>(outlets + offers)
    end
  end
end
