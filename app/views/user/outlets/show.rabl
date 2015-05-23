object @outlet
attributes :id, :name, :city, :street
child(:vendor) do
    attributes :name, :id
end
child(:deals) do
    attributes :title, :id
    child(:offers) do

    end
end
node :distance do |outlet|
    outlet.distance_from_current_loc
end