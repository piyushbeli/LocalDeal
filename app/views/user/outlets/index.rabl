object false

child @outlets => :items do
  attributes :name, :distance, :city, :street, :slug
  child(:vendor) do
    attributes :name
  end
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
  node(:review_count) do
  |outlet|
    outlet.no_of_comments
  end
end
node :total_items do
  @total_items
end