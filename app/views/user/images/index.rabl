object @images
attributes :id, :url, :created_at
child :uploader do
    attributes :slug, :name, :image
end
child :offer do
    attributes :what_you_get
end