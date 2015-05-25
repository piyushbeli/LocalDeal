collection @orders
attributes :what_you_get, :created_at, expiry_time
child :vendor do
    attributes :name, :id
end
node :no_of_valid_outlets do
    |order| order.outlets.count
end