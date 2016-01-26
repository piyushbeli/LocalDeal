module OutletImport
  def self.import
    Outlet.includes().find_in_batches do |outlets|
      bulk_index(outlets)
    end
  end

  def self.prepare_records(outlets)
    outlets.map do |outlet|
      {index: {data: outlet.as_indexed_json}}
    end
  end

  def self.bulk_index(outlets)
    # Delete the previous articles index in Elasticsearch
    Outlet.__elasticsearch__.client.indices.delete index: Outlet.index_name rescue nil

    Outlet.__elasticsearch__.client.bulk({
                                             index: ::Outlet.__elasticsearch__.index_name,
                                             type: ::Outlet.__elasticsearch__.document_type,
                                             body: prepare_records(outlets)
                                         })
  end
end

module DealImport
  def self.import
    Deal.includes().find_in_batches do |deals|
      bulk_index(deals)
    end
  end

  def self.prepare_records(deals)
    deals.map do |deal|
      {index: {data: deal.as_indexed_json}}
    end
  end

  def self.bulk_index(deals)
    # Delete the previous articles index in Elasticsearch
    Deal.__elasticsearch__.client.indices.delete index: Deal.index_name rescue nil

    Deal.__elasticsearch__.client.bulk({
                                             index: ::Deal.__elasticsearch__.index_name,
                                             type: ::Deal.__elasticsearch__.document_type,
                                             body: prepare_records(deals)
                                         })
  end
end

module OfferImport
  def self.import
    Offer.includes().find_in_batches do |offers|
      bulk_index(offers)
    end
  end

  def self.prepare_records(offers)
    offers.map do |offer|
      {index: {data: offer.as_indexed_json}}
    end
  end

  def self.bulk_index(offers)
    # Delete the previous articles index in Elasticsearch
    Offer.__elasticsearch__.client.indices.delete index: Offer.index_name rescue nil

    Offer.__elasticsearch__.client.bulk({
                                             index: ::Offer.__elasticsearch__.index_name,
                                             type: ::Offer.__elasticsearch__.document_type,
                                             body: prepare_records(offers)
                                         })
  end
end

# Index all article records from the DB to Elasticsearch
Outlet.import force: true
Deal.import force: true
Offer.import force: true