collection @deals
attributes :id, :title, :slug
node(:no_of_outlets) { |deal| deal.outletsCount }