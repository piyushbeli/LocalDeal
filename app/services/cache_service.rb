class CacheService

  def self.create_entity_key(entity, is_friendly)
    id = is_friendly ? entity.slug : entity.id
    key = entity.class.name + '-' + id.to_s
    return key.upcase
  end

  def self.add_entity(entity, is_friendly)
    key = create_entity_key(entity, is_friendly)
    val = entity.detail_json
    Rails.cache.write(key,val)
    return val
  end

  def self.delete_entity(entity, is_friendly)
    key = create_entity_key(entity, is_friendly)
    Rail.cache.delete(key)
  end

  def self.update_entity(entity, is_friendly)
    key = create_entity_key(entity, is_friendly)
    Rails.cache.delete(key)
    val = entity.detail_json
    Rails.cache.write(key, val)
  end

  def self.fetch_entity(class_name, id)
    key = class_name + '-' + id
    key = key.upcase
    val = Rails.cache.fetch(key)
    return val
  end

  def self.update_key(key, newVal)
    key = key.upcase
    #First delete old value
    Rails.cache.delete(key)
    #Now add new value
    Rails.cache.write(key, newVal)
  end

  def self.fetch_key(key)
    key = key.upcase
    return Rails.cache.fetch(key)
  end

  def self.delete_key(key)
    key = key.upcase
    Rails.cache.delete(key)
  end

  def self.delete_matched(pattern)
    pattern = pattern.upcase
    Rails.cache.delete_matched(pattern)
  end

end