object @user
attribute :slug, :name, :image
child :user_comments do
    attributes :title, :body, :created_at
    child :commentable do
        attributes :name, :city, :street, :slug
    end
end