object false

child  @reviews => :items do
  extends 'reviews/show'
end
node :total_items do
  @reviews.count
end
