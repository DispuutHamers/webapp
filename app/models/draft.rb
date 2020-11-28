class Draft < ApplicationRecord
  belongs_to :user
  belongs_to :entity, polymorphic: true

  has_rich_text :rich_data
end
