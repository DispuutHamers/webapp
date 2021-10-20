class Brew < ApplicationRecord
  belongs_to :recipe

  has_rich_text :description
end
