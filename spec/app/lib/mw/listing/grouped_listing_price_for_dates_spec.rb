describe Mw::Listing::GroupedListingPriceForDates do
  include_context "price for dates data"

  subject { described_class.new(Listing.with_seasonal_rates.find(listing.id), start_date, end_date) }

  it_behaves_like "price for dates"
end