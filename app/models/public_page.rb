class PublicPage < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  attribute :public, :boolean

  has_rich_text :content
end
