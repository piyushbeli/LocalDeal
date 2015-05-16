object @offer
attributes :discount, :what_you_get, :fine_print, :instruction, :start_time, :expire_time
child :type do
    attributes :name, :id
end