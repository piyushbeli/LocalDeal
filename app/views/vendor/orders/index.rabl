object false

child  @orders => :items do
  attributes :what_you_get, :created_at, :expire_at, :order_no, :redeemed
  child :user do
    attributes :name, :id, :image, :mobile, :email
  end
  child :outlet do
    attributes :id, :name, :street
  end
end

node :total_items do
  @orders.count
end