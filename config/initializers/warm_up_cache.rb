module WarmupCache
  def self.warm_up
    outlet
    offer
    deal
  end

  def self.outlet
    Outlet.find_in_batches do |outlets|
      outlets.each do |outlet|
        CacheService.update_entity(outlet, true)
      end
    end
  end

  def self.offer
    Offer.find_in_batches do |offers|
      offers.each do |offer|
        CacheService.update_entity(offer, false)
      end
    end
  end

  def self.deal
    Deal.find_in_batches do |deals|
      deals.each do |deal|
        CacheService.update_entity(deal, true)
      end
    end
  end

  def self.put(key, val)
    Rails.cache.write(key, val, expires_in: 1.hour)
  end
end