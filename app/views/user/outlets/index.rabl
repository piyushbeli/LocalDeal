collection @outlets
attributes :name, :distance, :city, :street, :slug
child(:vendor) do
    attributes :name
end
child(:deals) do
    attributes :title, :id
end
node(:markedAsFavorite) do |outlet|
  outlet.marked_as? :favorite, :by => @current_user
end