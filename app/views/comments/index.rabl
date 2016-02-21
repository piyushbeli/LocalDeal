object false

child  @comments => :items do
  extends 'comments/show'
end
node :total_items do
  @total_comments
end
