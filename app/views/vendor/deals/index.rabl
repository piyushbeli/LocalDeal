collection @deals
attributes :id, :title
node(:no_of_outlets) { |deal| deal.outletsCount }