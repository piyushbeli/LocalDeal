object @order
attributes :what_you_get, :fine_print, :instruction, :created_at, :expire_at, :order_no
child :user do
    attributes :name, :id, :email, :mobile, :photo
end
child :outlet do
    attributes :name, :slug
end