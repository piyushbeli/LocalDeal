object false

child @outlets => :items do
  attributes :name, :distance, :city, :street, :slug, :no_of_comments
  child(:deals) do
    attributes :title, :id
  end
  node(:marked_as_favorite) do |outlet|
    outlet.marked_as? :favorite, :by => @current_user unless @current_user.nil?
  end
  node(:rating) do |outlet|
    outlet.average_rating
  end
  node(:no_of_raters) do |outlet|
    outlet.no_of_raters
  end
  node :profile_pic do |outlet|
      outlet.vendor.image
  end
end

node :total_items do
  @total_items
end
