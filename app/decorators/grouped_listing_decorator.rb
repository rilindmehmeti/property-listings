class GroupedListingDecorator < ListingDecorator
  def price
    Mw::Listing::GroupedListingPriceForDates.new(object, start_date, end_date).call
  end
end
