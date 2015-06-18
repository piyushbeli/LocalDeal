object @deal
attributes :id, :title, :description, :slug
child :outlets do
    attributes :id, :slug, :name, :longitude, :latitude, :city, :city_id, :address, :email, :mobile, :contact_no
end
child :offers do
    attributes :id, :slug, :what_you_get, :fine_print, :instruction, :discount, :start_time, :expire_time
    child :offer_type do
        attributes :id, :name, :description
    end
end