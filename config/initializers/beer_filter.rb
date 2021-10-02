class BeerFilter
  include Minidusen::Filter

  filter :text do |scope, phrases|
    columns = [:name, :brewer, :kind]
    scope.where_like(columns => phrases)
  end

  filter :land do |scope, phrases|
    columns = [:country]
    scope.where_like(columns => phrases)
  end

  filter :brouwer do |scope, phrases|
    columns = [:brewer]
    scope.where_like(columns => phrases)
  end

  filter :naam do |scope, phrases|
    columns = [:name]
    scope.where_like(columns => phrases)
  end

  filter :kind do |scope, phrases|
    columns = [:kind]
    scope.where_like(columns => phrases)
  end
end
