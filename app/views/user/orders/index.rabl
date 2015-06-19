collection @orders
attributes :what_you_get, :created_at, :expire_at, :order_no, :redeemed
child :vendor do
    attributes :name, :id, :image
end
child :outlet do
    attributes :id, :street
end