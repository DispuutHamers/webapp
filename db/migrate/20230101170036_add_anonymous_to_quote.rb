class AddAnonymousToQuote < ActiveRecord::Migration[6.1]
  def change
    Quote.all.each(&:save)
    # TODO remove all records with deleted_at != nil to anonymous and remove all from version history
    add_column :quotes, :anonymous, :boolean, default: false
  end
end
