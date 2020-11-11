describe Mw::Listing::PriceForDates do
  include_context "price for dates data"

  subject { described_class.new(listing, start_date, end_date) }

  it_behaves_like "price for dates"
end
