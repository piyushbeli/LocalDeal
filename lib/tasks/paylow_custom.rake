namespace :paylow_custom do
  desc 'Create the elastic search index from models'
  task warmup_elastic_search_index: :environment do
=begin
    OutletImport.import
    DealImport.import
    OfferImport.import
=end
  Outlet.import force: true
  Offer.import force: true
  Deal.import force: true
  end

  desc 'Warmup cache for different models'
  task warm_up_cache: :environment do
    WarmupCache.warm_up
  end

end
