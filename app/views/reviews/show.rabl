object @review
attributes :id, :title, :body
child :commentator => :reviewer do
    attributes :id, :name, :image
end