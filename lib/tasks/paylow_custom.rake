namespace :paylow_custom do
  desc 'Create the elastic search index from models'
  task warmup_elastic_search_index: :environment do
    Outlet.import force: true
    Deal.import force: true
    Offer.import force: true
  end

end
