class BeerFilter
  include Minidusen::Filter

  filter :text do |scope, phrases|
    columns = [:name, :brewer, :soort]
    scope.where_like(columns => phrases)
  end
end
