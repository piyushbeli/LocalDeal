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
    child :offers do
        attributes :id, :what_you_get, :fine_print, :instruction, :start_at, :expire_at
    end
    child :outlets do
        attributes :name, :id, :street_address
    end
end

node :distance do |outlet|
    outlet.distance_from_current_loc
end

node :review_count do
  |outlet|
  outlet.comments.count
end

child :comments => :reviews do
  extends 'reviews/show'
end

node(:marked_as_favorite) do |outlet|
  outlet.marked_as? :favorite, :by => @current_user unless @current_user.nil?
end

node(:user_rating) do |outlet|
  outlet.user_rating (@current_user)
end

node(:rating) do |outlet|
  outlet.average_rating
end

node(:no_of_raters) do |outlet|
  outlet.no_of_raters
end
