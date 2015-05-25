object @order
attributes :what_you_get, :fine_print, :instruction, :created_at, expire_at
child :vendor do
    attributes :name, :id
end
child :outltes do
    attributes :name, :city, :street, :mobile_no, :contact_no, :latitude, :longitude
end