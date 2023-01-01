# Entry point for the quote resource
class QuotesController < ApplicationController
  before_action :ilid?
  breadcrumb 'Quotes', :quotes_path

  def index
    redirect_to root_path
  end

  def show
    redirect_to root_path
  end

  def create
    quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
    quote.reporter_id = current_user.id
    save_object(quote)
  end

  def edit
    @quote = Quote.find_by_id!(params[:id])
    @userid = @quote.user_id
    breadcrumb 'Wijzig citaat', edit_quote_path(@quote)
  end

  def update
    quote = Quote.find_by_id!(params[:id])
    puts quote_params
    puts quote.user_id
    puts params[:user_id]
    if quote.anonymous && (params[:user_id] && quote.user_id != params[:user_id].to_i)
      flash.now[:error] = 'Je kan geen anonieme quote bewerken.'
      return render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end
    update_object(quote, quote_params)
  end

  def destroy
    quote = Quote.find_by_id!(params[:id])
    # TODO make sure this does not end up in quote.versions
    delete_object(quote)
  end

  def anonymous
    quote = Quote.find_by_id!(params[:id])
    if (quote && quote.user_id == current_user.id) || current_user.admin?
      quote.anonymous = true
      quote.reporter = nil
      quote.user = nil

      quote.versions.each do |version|
        version.whodunnit = nil
        version.save
      end

      if quote.save
        flash[:success] = 'Quote is nu anoniem'
        return redirect_to root_path
      else
        flash.now[:error] = quote.errors.full_messages.join('<br>')
      end
    else
      flash.now[:error] = 'Alleen een admin of de eigenaar van een quote kan deze anoniem maken.'
    end
    render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
  end
end
