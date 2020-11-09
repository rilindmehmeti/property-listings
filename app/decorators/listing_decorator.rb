class ListingDecorator < Draper::Decorator
  delegate_all

  def price
    Mw::Listing::PriceForDates.new(object, start_date, end_date).call
  end

  private

  def start_date
    context[:start_date]
  end

  def end_date
    context[:end_date]
  end
end
