object @outlet
attributes :id, :name, :city, :street, :slug, :address, :no_of_comments, :latitude, :longitude, :mobile, :contact_no, :email
child(:vendor) do
    attributes :name, :slug
    node :spammed do
      |vendor| vendor.spammed_by_user?(@current_user) unless @current_user.nil?
    end
end
child(:deals) do
    attributes :title, :slug
    child :offers do |offer|
        attributes :id, :slug, :what_you_get, :discount, :what_you_get, :fine_print, :instruction, :start_at, :expire_at, :end_at, :max_no_of_coupons, :actual_price, :offered_price, :total_no_of_orders, :coupons_remaining
        node :is_expired do
            |offer| offer.is_expired?
        end
        node :sold_out do
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

node(:images) do |outlet|
    outlet.outlet_images.select(:id, :url).limit(5)
end

node(:total_images) do |outlet|
    outlet.outlet_images.count
end
