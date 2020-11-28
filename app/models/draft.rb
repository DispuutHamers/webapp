class Draft < ApplicationRecord
  belongs_to :user

  has_rich_text :rich_data
end
