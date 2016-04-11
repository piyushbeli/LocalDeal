object @outlet
attributes :id, :name, :city, :street, :slug, :address, :no_of_comments, :latitude, :longitude
child(:vendor) do
    attributes :name, :slug
    node :spammed do
      |vendor| vendor.spammed_by_user?(@current_user) unless @current_user.nil?
    end
end
child(:deals) do
    attributes :title, :slug
    child :offers do |offer|
        attributes :id, :what_you_get, :fine_print, :instruction, :start_at, :expire_at, :total_no_of_orders, :coupons_remaining
        node :is_expired do
            |offer| offer.is_expired?
        end
        node :limit_reached do
            |offer| offer.limit_reached?
        end
    end
end

node :distance do |outlet|
    outlet.distance_from_current_loc
end

node(:marked_as_favorite) do |outlet|
  outlet.marked_as? :favorite, :by => @current_user unless @current_user.nil?
end

node(:user_rating) do |outlet|
  outlet.user_rating(@current_user)
end

node(:rating) do |outlet|
  outlet.average_rating
end

node(:no_of_raters) do |outlet|
  outlet.no_of_raters
end
