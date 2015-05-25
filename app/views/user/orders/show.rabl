object @order
attributes :what_you_get, :fine_print, :instruction, :created_at, :expire_at, :order_no
child :vendor do
    attributes :name, :id
end
child :outlet do
    attributes :name, :city, :street, :mobile_no, :contact_no, :latitude, :longitude
end