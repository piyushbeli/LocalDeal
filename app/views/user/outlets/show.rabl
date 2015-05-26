object @outlet
attributes :name, :city, :street, :slug
child(:vendor) do
    attributes :name, :id
    node :spammed do
      |vendor| vendor.spammed_by_user?(@current_user) unless @current_user.nil?
    end
end
child(:deals) do
    attributes :title, :slug
    node :review_count do
        |deal| deal.comments.count
    end
    child :offers do
        attributes :id, :what_you_get, :fine_print, :instruction, :start_at, :expire_at
    end
    child :outlets do
        attributes :name, :id, :street_address
    end
    node :reviews do
        |deal|
        partial('reviews/show', :object => deal.comments.order("created_at DESC").limit(10))
    end

end
node :distance do |outlet|
    outlet.distance_from_current_loc
end