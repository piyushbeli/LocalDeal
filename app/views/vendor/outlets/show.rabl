object @outlet
attributes :name, :slug, :longitude, :latitude, :address, :email, :mobile, :contact_no, :no_of_followers, :no_of_comments

node :images do |outlet|
    @images
end

node :menus do |outlet|
    @menus
end