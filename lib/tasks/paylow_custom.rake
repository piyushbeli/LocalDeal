namespace :paylow_custom do
  desc 'Create the elastic search index from models'
  task warmup_elastic_search_index: :environment do
    Outlet.reindex
    Offer.reindex
  end

  desc 'Warmup cache for different models'
  task warm_up_cache: :environment do
    WarmupCache.warm_up
  end

end
