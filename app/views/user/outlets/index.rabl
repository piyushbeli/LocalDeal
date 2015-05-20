collection @outlets
attributes :id, :name, :distance, :city, :street
child(:vendor) do
    attributes :name
end
child(:deals) do
    attributes :title
end