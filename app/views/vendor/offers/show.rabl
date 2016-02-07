object @offer
attributes :discount, :what_you_get, :fine_print, :instruction, :start_at, :expire_at, :end_at, :max_no_of_coupons
child :type do
    attributes :name, :id
end