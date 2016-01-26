object @deal
attributes :id, :title, :description, :slug
child :outlets do
    attributes :id, :slug, :name
end
child :offers do
    attributes :id, :slug, :what_you_get, :fine_print, :instruction, :discount, :start_at, :expire_at
    child :offer_type do
        attributes :id, :name, :description
    end
end