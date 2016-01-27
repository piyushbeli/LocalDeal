object @vendor
attribute :name, :slug, :about_me, :image
child :outlets do
    attribute :name, :slug, :city, :street, :address, :no_of_comments, :latitude, :longitude
    node(:rating) do |outlet|
      outlet.average_rating
    end
    node :no_of_raters do |outlet|
        outlet.no_of_raters
    end
end