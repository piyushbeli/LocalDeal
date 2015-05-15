collection @deals
attributes :id, :title
node(:no_of_outlets) { |deal| deal.outletsCount }
child :vendor do
    attribute :name
    child :categories do
        attribute :name
    end
end
