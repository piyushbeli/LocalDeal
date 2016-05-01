object @menus
attributes :id, :url, :caption, :created_at
child :uploader do
    attributes :slug, :name, :image
end