object @outlet
attributes :id, :name, :city, :street
child(:vendor) do
    attributes :name, :id
end
child(:deals) do
    attributes :title, :id
    node :review_count do
        |deal| deal.comments.count
    end
    child(:offers) do

    end
    node(:reviews) do
        |deal|
        partial('reviews/show', :object => deal.comments.order("created_at DESC").limit(10))
    end

end
node :distance do |outlet|
    outlet.distance_from_current_loc
end