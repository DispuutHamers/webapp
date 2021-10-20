class Recipe < ApplicationRecord
  has_many :brews

  has_rich_text :description
end
