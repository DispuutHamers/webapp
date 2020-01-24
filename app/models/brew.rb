class Brew < ApplicationRecord
  belongs_to :recipe

  has_rich_text :actiontext_description
end
