class AddAnonymousToQuote < ActiveRecord::Migration[6.1]
  def change
    add_column :quotes, :anonymous, :boolean, default: false

    Quote.where.not(deleted_at: nil).each do |quote|
      quote.anonymous = true
      quote.user = nil
      quote.reporter = nil
      quote.save
      quote.versions.each do |version|
        version.destroy
      end
    end
  end
end
