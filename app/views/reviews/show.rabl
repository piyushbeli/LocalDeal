object @review
attributes :id, :title, :body, :created_at
child :commentator => :reviewer do
    attributes :id, :name, :image
end
child :comments do
    attributes :body, :created_at
    child :commentator => :reviewer do
        attributes :id, :name, :image
    end
end
