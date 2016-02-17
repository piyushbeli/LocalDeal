object false
collection @comments

extends 'comments/show'
node :total_items do
  @total_comments
end
