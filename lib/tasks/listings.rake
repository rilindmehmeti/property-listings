desc "Generates Listings"
task :generate_listings, [:listings] => [:environment] do |t, args|
  listings_no = args[:listings].to_i
  prices = [100, 200, 300, 400, 500, 600, 700]
  listings_no.times do
    title = (0...8).map { (65 + rand(26)).chr }.join
    default_daily_rate = prices.sample
    seasonal_rate = default_daily_rate + 50
    start_date = Date.parse("01-07-2021")
    end_date = Date.parse("01-09-2021")
    listing = Listing.create(title: title, default_daily_rate: default_daily_rate)
    SeasonalRate.create(listing: listing, start_date: start_date, end_date: end_date, daily_rate: seasonal_rate)
  end
end
