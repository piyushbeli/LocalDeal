object @deal
attributes :id, :title, :description, :slug
child :outlets do
    attributes :id, :slug, :name
end
child :offers do
    attributes :id, :slug, :what_you_get, :discount, :what_you_get, :fine_print, :instruction, :start_at, :expire_at, :end_at, :max_no_of_coupons, :actual_price, :offered_price
    child :offer_type do
        attributes :id, :name, :description
    end
end