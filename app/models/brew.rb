class Brew < ApplicationRecord
  belongs_to :recipe

  has_rich_text :actiontext_description
  has_rich_text :description

  before_save do
    self.description = self.actiontext_description
    self.actiontext_description.destroy
  end
end
