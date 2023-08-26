class AnonymousOldQuotes < ActiveRecord::Migration[6.1]
  def change
    Quote.where.not(deleted_at: nil).each do |quote|
      quote.user = nil
      quote.reporter = nil
      quote.save
      quote.destroy_history
    end
  end
end
