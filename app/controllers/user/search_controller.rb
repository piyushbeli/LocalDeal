class User::SearchController < ApplicationController
  def search
    if params[:q].nil?
      @articles = []
    else
      outlets = Outlet.search(params[:q]).results.as_json
      deals = Deal.search(params[:q]).results.as_json
      offers = Offer.search(params[:q]).results.as_json

      outlets = outlets.map do |outlet|
        outlet = outlet['_source']
        {id: outlet['id'], type: 'Outlet', name: outlet['name']}
      end
      deals = deals.map do |deal|
        deal = deal['_source']
        {id: deal['id'], type: 'Deal', name: deal['title']}
      end
      offers = offers.map do |offer|
        offer = offer['_source']
        {id: offer['id'], type: 'Offer', name: offer['what_you_get']}
      end

      render :json=>(outlets + deals + offers)
    end
  end
end
