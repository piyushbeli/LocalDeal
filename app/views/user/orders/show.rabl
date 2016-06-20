object @order
attributes :what_you_get, :order_no, :redeemed, :redeemed_at, :is_active, :coupon_code, :fine_print, :instruction, :created_at, :expire_at
child :vendor do
    attributes :name, :id
end
child :outlet do
    attributes :name, :city, :street, :mobile_no, :contact_no, :latitude, :longitude
end