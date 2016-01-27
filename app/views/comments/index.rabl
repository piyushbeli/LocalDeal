object false

child  @comments => :items do
  extends 'comments/show'
end
node :total_items do
  @comments.count
end
